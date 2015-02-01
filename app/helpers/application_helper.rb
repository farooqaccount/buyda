module ApplicationHelper
    
  def resource_name
    :user
  end
 
  def resource
    @resource ||= User.new
  end
 
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
    
    def get_cart_products
        if session[:cart_id].nil?
            
            @cart_products = CartProduct.where("user_id=?",current_user.id)
        else
            @cart_products = CartProduct.where("cart_id = ?",session[:cart_id])
        end
    end
    
    def get_wishlist_count
        if current_user
            wishlist = Wishlist.find_by("user_id=?",current_user.id)
            if wishlist.present?
                wishlist_items = WishlistItem.where("wishlist_id=?",wishlist.id)
                wishlist_count = wishlist_items.count
            else
                wishlist_count = 0
            end
        else
            wishlist_count = 0
        end
    end
    
    def my_button_to name, options = {}, html_options = {} # or some variation
  # eg. deal with options hash the way button_to deals with it here?
  content_tag :button_to, html_options = nil do
    raw name
  end
    
    def get_cart_products
        if session[:cart_id].nil?
            
            @cart_products = CartProduct.where("user_id=?",current_user.id)
        else
            if !params[:cart_id].present?
                @cart_products = CartProduct.where("cart_id = ?",session[:cart_id])
            else
                session[:cart_id] = params[:cart_id]
                @cart_products = CartProduct.where("cart_id = ?",params[:cart_id])
            end
        end
    end
end

def calculate_total(coupon,cart_product)
        
        if !coupon.nil? && coupon.coupon_type.eql?("Fixed Amount") 
            product_price = (cart_product.product.price - coupon.discount) * cart_product.quantity
            cart_product.update_columns(:product_price => product_price)
            return product_price
        elsif !coupon.nil? && coupon.coupon_type.eql?("Percentage")
            product_price = (cart_product.product.price - (cart_product.product.price * coupon.discount / 100)) * cart_product.quantity
            cart_product.update_columns(:product_price => product_price)
            return product_price
        else
            product_price = cart_product.product.price * cart_product.quantity
            cart_product.update_columns(:product_price => product_price)
            return product_price 
        end
        
    end

def validate_coupon(cart_products,coupon, session,total_price)
        
    if cart_products.present? && coupon.present? && coupon.user_logged_in == true
            if current_user
                 if coupon.coupon_code.present?
                    if coupon.coupon_histories.present? && coupon.coupon_histories.where(coupon.id).present? && coupon.coupon_histories.where(coupon.id).count > coupon.uses_per_coupon
                        return 'Invalid coupon code, please try a different coupon code!'
                    else
                        if session[:coupon_usage]
                            coupon_usage_carts = session[:coupon_usage].to_s.split('_')
                            coupon_usage_cart = coupon_usage_carts[1]
                            if coupon_usage_cart.eql?(cart_products.first.cart_id.to_s)
                                return 'SUCCESS'
                            end # end of coupon usage
                        else
                            if coupon.present? && coupon.coupon_histories.present? && coupon.coupon_histories.where("coupon_id = ? and user_id = ?",coupon.id,current_user_id).present? && coupon.coupon_histories.where("coupon_id = ? and user_id = ?",coupon.id,current_user_id).count > coupon.uses_per_user
                                return 'Coupon has already been used, please use a different coupon!'
                            else
                                if coupon.present? && coupon.total_amount.present? && total_price < coupon.total_amount
                                    return 'Coupon is valid only if the total amount is #{coupon.total_amount} or greater !'
                                else
                                    if Date.today >= coupon.start_date && Date.today <= coupon.end_date
                                        session[:coupon_usage] = (current_user.id+coupon.id).to_s+"_"+(cart_products.first.cart_id).to_s
                                        return 'SUCCESS'
                                    else
                                        return 'Coupon has expired!'
                                    end # end of date check
                                    
                                end # end of total amount check
                                    
                            end # end of counting the current user usage coupon
                            
                        end #end of session of coupon usage
                    end #end of checking the history
                 else
                     return 'Coupon code is invalid!'
                 end #end of checking the coupon code present
                        
            end #end of current user
        else
            if cart_products.present? && coupon.present?
               if coupon.coupon_code.present?
                   if coupon.coupon_histories.present? &&     coupon.coupon_histories.where(coupon.id).present && coupon.coupon_histories.where(coupon.id).count > coupon.uses_per_coupon
                       return 'Invalid coupon code, please try a different coupon code!'
                   else
#                        if session[:coupon_usage]
#                           return 'Coupon is already applied!' 
#                        else
                           if coupon.total_amount.present? && total_price < coupon.total_amount
                                    return 'Coupon is valid only if the total amount is #{coupon.total_amount} or greater !'
                           else
                               if Date.today >= coupon.start_date && Date.today <= coupon.end_date
                              session[:coupon_usage] = current_user.id+coupon.id 
                                   
                                   return 'SUCCESS'
                               else
                                   return 'Coupon has expired!'
                               end # coupon date check
                           end # end of total amount calc check
                       #end # end of session coupon usage
                   end #end of history check 
               else
                     if cart_products.present?  && coupon.present?
                         return 'Coupon code is invalid!'
                     end
               end #end of coupon code present
            else
                if cart_products.present? && coupon.present?
                   return 'Coupon code is invalid!'
               end
            end #end of coupon present
        end #end of coupon present and current user
    end # end of def

    def find_by_coupon_code(coupon_code)
        Coupon.find_by("coupon_code=?",coupon_code)
    end

    def orders_chart_series(orders, start_time)
        orders_by_day = orders.where(:created_at => start_time.beginning_of_day..Time.zone.now.end_of_day).
                    group("date(created_at)").
                    select("created_at, sum(discounted_total) as discounted_total")
    (start_time.to_date..Date.today).map do |date|
      order = orders_by_day.detect { |order| order.created_at.to_date == date }
      order && order.discounted_total.to_f || 0
    end.inspect
  end

def group_by_day
    orders_by_day = Order.where(:created_at => 10.weeks.ago.beginning_of_day..Time.zone.now.end_of_day).
                    group("date(created_at)").
                    select("created_at, sum(discounted_total) as discounted_total")
        
  end
    
end
