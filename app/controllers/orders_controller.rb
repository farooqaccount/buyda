class OrdersController < ApplicationController
    
    def index
        @orders = Order.all
    end
    
    def new
        @order = Order.new
        @order.build_order_shipping_detail
    end
    
    def create
        @order = Order.new(order_params)
        @order.user_id = current_user.id
        @order.order_shipping_detail.user_id = current_user.id
        @order.cart_id = session[:cart_id]
        @order.total = session[:total_price]
        @order.discounted_total = session[:grand_total]
        @order.coupon = session[:coupon]
        logger.warn " Cart Id **** #{@order.cart_id}"
        logger.warn " Total **** #{@order.total}"
        logger.warn " Discounted Total **** #{@order.discounted_total}"
        if @order.save
            #Cart.destroy
            
            Notifications.new_order(@order).deliver
            session[:cart_id] = nil
            session[:total_price] = nil
            session[:grand_total] = nil
            session[:coupon] = nil
            session[:discount] = nil
            session[:coupon_usage] = nil
            
            redirect_to order_path(@order.id), notice: "Successfully added the order"
        else
            render :new
        end
    end
    
    def show
        @order = Order.find(params[:id])
        @order_history = OrderHistory.new
        
        
    end
    
    def edit
        @order = Order.find(params[:id])
        @order_history = OrderHistory.new
    end
    
    def update
        @order = Order.find(params[:id])
        @order.user_id = current_user.id
        if @order.update(order_params)
            Notifications.update_order(@order).deliver
            redirect_to order_path(@order.id), notice: "Successfully added the order"
        else
            render :new
        end
    end
    
    def destroy
    end
    
    def generate_invoice
        @order = Order.find(params[:id])
        respond_to do |format|
            format.html
            format.pdf do
                pdf = InvoicePdf.new(@order)
#                 pdf.text "Order details"
                send_data pdf.render, filename: "#{@order.invoice_no}", type: "application/pdf"

            end
        end
    end

    private
    
    def order_params
    if params[:order]["card_expires_on(1i)"] && params[:order]["card_expires_on(2i)"] &&  params[:order]["card_expires_on(3i)"]
    ## Set "card_expires_on" to a "Date" object created using the three values
    ## passed from the form "card_expires_on(1i)" and "card_expires_on(2i)", "card_expires_on(3i)" 
    params[:order][:card_expires_on] =             Date.new(params[:order].delete("card_expires_on(1i)").to_i,     params[:order].delete("card_expires_on(2i)").to_i , params[:order].delete("card_expires_on(3i)").to_i)
  end
                params.require(:order).permit(:invoice_no,:user_id,:order_status_id,:name,:address,:payment_type,:card_type,:card_number,:card_verification,:card_expires_on,:first_name,:last_name,order_shipping_detail_attributes: [:id, :name, :address,:zip_code])
    end
    
end
