class Admin::PagesController < Admin::AdminController
    
    before_filter :authenticate_user!
    
    before_filter :ordrer_product_information
    before_filter :recently_viewed_product_information
    respond_to :html, :js
    
    DEFAULT_NO_OF_RECORDS = 5
    
    def dashboard
        @products = Product.order("created_at DESC").take(5)
        #@latest_orders = Order.order("created_at DESC").take(10)
        @latest_orders = Order.where("created_at >= ?",10.days.ago)
        #@latest_orders = Order.where(:created_at => Time.now.beginning_of_day..Time.now.end_of_day)
        @orders_count = Order.count
        @total_sales = Order.sum("discounted_total")
        @total_customers = Order.get_total_customers
        @orders = Order.all
        @top_selling_products = top_sell_products
        @top_viewed_products = top_viewed_products
        @new_customers_orders = new_customers_orders
        @customer_order_details = customer_order_status(params[:order_stats])
        
        data_table = GoogleVisualr::DataTable.new
        @orders_chart = orders_chart(data_table,params[:order_chart_options])
        
        products_data_table = GoogleVisualr::DataTable.new
        @top_products_chart = top_products_chart(products_data_table,params[:product_chart_options])
        
    end
    
    
    
    def admin_home
        @manufacturer_products = ManufacturerProduct.order("created_at DESC")
    end
    
    def order_details
        logger.debug " Inside order details action ****************"
        @customer_order_details = customer_order_status(params[:order_stats])
        logger.debug " Cust order details #{@customer_order_details.size}"
         respond_to do |format|
            format.html
            format.json
         end
  

    end
    
    def about
    end
    
    def contact
    end
    
    def help
    end
    
    def terms
    end
    
    def privacy
    end
    
    def documentation
    end

    private 

    def ordrer_product_information
        @products_info = Product.includes(:order_products).all.map { |p| [p.id, p.name,p.price, p.order_products.size] }
    end
    
    def recently_viewed_product_information
        @recently_viewed_products_info = Product.includes(:trackables).all.map { |p| [p.id, p.name,p.price, p.trackables.size] }
    end
    
    def top_viewed_products
        if !@recently_viewed_products_info.nil?
            @recently_viewed_products_info.sort_by(&:last).reverse.take(10)
        else
            nil
        end
        
    end
    
    def top_sell_products
        @products_info.sort_by(&:last).reverse.take(10)
        
    end
    
    def new_customers_orders
        
        #User.joins(:orders,:roles).where("users.created_at =? AND roles.name like ?",30.days.ago,"customer").last(10).map{|u| [u.user_name, u.orders.size,u.orders.inject(0){|sum, o| sum += o.discounted_total}]}.uniq
        
        User.joins(:orders,:roles).where("roles.name like ?","customer").last(10).map{|u| [u.user_name, u.orders.size,u.orders.inject(0){|sum, o| sum += o.discounted_total}]}.uniq
    end
    
    def customer_order_status(status)
      
        if status.present? && !status.eql?('10Orders')
            order_status = OrderStatus.find_by("name =?",status)
            order_status_id = order_status.id
        end
        
        if status.nil? || (!status.nil? && status.eql?('10Orders'))
        Order.joins(:order_histories).order("order_histories.created_at ASC").last(10).map{|o| [o.id,o.user.user_name,o.created_at,o.discounted_total,o.order_histories[o.order_histories.length-1].order_status.name]}
        elsif !status.nil? && !status.eql?("10Orders")
            Order.joins(:order_histories).order("order_histories.created_at ASC").where("order_histories.order_status_id =?",order_status_id).last(10).map{|o| [o.id,o.user.user_name,o.created_at,o.discounted_total,o.order_histories[o.order_histories.length-1].order_status.name]}
       
        end
    end
    
    def orders_chart(data_table,order_chart_options)
        
        order_select_value = ""
         if order_chart_options.present? && !order_chart_options.nil?
            order_select_value = order_chart_options
        end
        
        if !order_chart_options.present? || order_chart_options.nil?
            order_select_value = "monthWise"
        end
        data_table.new_column('string', order_select_value == "monthWise" ? 'Month' : 'Day')
        
        data_table.new_column('number', 'Orders')
        logger.debug " order select value #{order_select_value}"
        if order_select_value == "monthWise"
            orders_chart = Order.where(:created_at => Date.today.beginning_of_month - 6.months...Date.today).order('created_at ASC')
        else
            orders_chart = Order.where(:created_at => 2.weeks.ago...Date.today).order('created_at ASC')
        end
        
        if order_select_value == "monthWise"
            orders_chart_group = orders_chart.group_by { |t| t.created_at.beginning_of_month} 
        else
            orders_chart_group = orders_chart.group_by { |t| t.created_at.beginning_of_day}
        end
             
        data_table.add_rows(orders_chart_group.keys.length)
        
        orders_chart_group.each_with_index do |(month,orders),index|
            if order_select_value == "monthWise"
                data_table.set_cell(index, 0, month.strftime("%B"))
            else
                data_table.set_cell(index, 0, month.strftime("%d"))
            end
                data_table.set_cell(index, 1, orders.length)
                       
        end
       
        if order_select_value == "monthWise"
            xaxis = 'Month'
        else
            xaxis = 'Day'
        end
        opts   = { :width => 500, :height => 300, :title => '', 
            :hAxis => 
            { :title => xaxis, :titleTextStyle => {:color => 'blue', :fontsize => '16'}},
            :vAxis => 
                    { 
                        :title => 'Orders', 
                        :titleTextStyle => {:color => 'blue', :fontsize => '16'} 
                    } 
            }
    chart = GoogleVisualr::Interactive::ColumnChart.new(data_table, opts)
    end
    
    def top_products_chart(data_table,product_chart_options)
        data_table.new_column('string', 'Products')
        data_table.new_column('number', 'Sales')
        top_products = nil
        #products_chart = Product.includes(:order_products).all.map { |p| [p.id, p.name, p.order_products.size] }
        
        if product_chart_options.present? && !product_chart_options.nil?
            if product_chart_options == "top5"
                top_products = Product.includes(:order_products).all.map { |p| [p.id, p.name, p.order_products.size] }.sort_by(&:last).reverse.take(5)
            elsif product_chart_options == "top10"
                top_products = Product.includes(:order_products).all.map { |p| [p.id, p.name, p.order_products.size] }.sort_by(&:last).reverse.take(10)
            end
        else
            top_products = Product.includes(:order_products).all.map { |p| [p.id, p.name, p.order_products.size] }.sort_by(&:last).reverse.take(5)
        end
        data_table.add_rows(top_products.length)
        
        top_products.each_with_index do |product,index|
           
            data_table.set_cell(index, 0, "#{top_products[index][1]}")
            data_table.set_cell(index, 1, top_products[index][2])
            
        end
       
#             options = {
#                       title: 'title',
#                       strictFirstColumnType: true,
#                       lineWidth: 1,
#                       isStacked: true,
#                       legend: { position: 'bottom', alignment: 'left', textStyle: { color: 'black', fontSize: 15, italic: false, bold: true }, maxLines: 5 },
#                       vAxes: { 1: { title: 'y1TitleText'e,  titleTextStyle: { italic: false, bold: true }, minValue:0, gridlines: { count: 6 } } },
#                       hAxis: {slantedText: true, slantedTextAngle: 90, title: 'titleText'},
#                       fontSize: 15,
#                       colors: colors
#                   };
       
            opts   = { 
                allowHtml: true,
                is3D: true,
                :width => 500, :height => 300, :title => '', 
                :hAxis => 
                    { 
                        :title => 'Products', 
                        :titleTextStyle => {:color => 'blue', :fontsize => '16'} 
                    },
                :vAxis => 
                    { 
                        :title => 'Sold', 
                        :titleTextStyle => {:color => 'blue', :fontsize => '16'} 
                    }
                  


                }
    product_chart = GoogleVisualr::Interactive::ColumnChart.new(data_table, opts)
    end
end
