class CartProductsController < ApplicationController
    include ApplicationHelper
    respond_to :html, :json
    before_filter :create_cart, only: [:create, :destroy]
    # before_action is at model level
    
    def index
        @total_price = 0
        
        if params[:coupon]
            coupon = Coupon.find_by_coupon_code(params[:coupon])
            if coupon.present?
                @coupon = coupon
                session[:coupon] = coupon.coupon_code
            
            end
         elsif session[:coupon]
            coupon = Coupon.find_by_coupon_code(session[:coupon])
            if coupon.present?
                @coupon = coupon
                params[:coupon] = coupon.coupon_code
                       
            end
        end
        
        
        
        #@total_price = Product.joins(:cart_products).where('cart_id = ?', session[:cart_id]).sum(:price)
        cart_products = get_cart_products
        cart_products.each do |cart_product|
            quan = cart_product.quantity
            price = cart_product.product_price#Product.where("id=?",cart_product.product_id).pluck(:price)
           # price = price
            
            @total_price +=  price
            valid_product_coupon = !@coupon.nil? && !@coupon.product_coupons.nil? ? @coupon.product_coupons.find_by_product_id(cart_product.product.id) : false 
            
            valid_manufacturer_coupon = !@coupon.nil? && !@coupon.manufacturer_coupons.nil? ? (!cart_product.product.manufacturer.nil? ? @coupon.manufacturer_coupons.find_by_manufacturer_id(cart_product.product.manufacturer.id) : false) : false
            
            valid_category_coupon = !@coupon.nil? && !@coupon.category_coupons.nil? ? (!cart_product.product.category.nil? ? @coupon.category_coupons.find_by_category_id(cart_product.product.category.id): false) : false
            if valid_product_coupon ||  valid_manufacturer_coupon || valid_category_coupon
                cart_product.update_columns(:has_coupon => true)
            end
    #        
        end
        
        @is_coupon_valid = validate_coupon(cart_products,@coupon,session,@total_price)
        
    end
    
    def create
        @cart_product = CartProduct.new
           
        if !find_by_product_id(params[:product_id]).exists?
            @cart_product.quantity = 1
            @cart_product.product_id = params[:product_id]
            @cart_product.cart_id = session[:cart_id]
            @cart_product.user_id = current_user.id
            @cart_product.product_price = params[:price]
            @return_url = (request.env["HTTP_REFERER"]).gsub(/\?.*/,'')
            if @cart_product.save
                if params[:wishlist_item].present?
                    @wishlist_item = WishlistItem.find(params[:wishlist_item])
                    @wishlist_item.delete
                end
                redirect_to cart_products_path, notice: "Successfully added the product in the cart"
            else
                #render :back, alert: "Unable to process your request"
                render @return_url, alert: "Unable to process your request"
            end
            else
                update
                
                
                
            end
               
    end
    
    def update
        if params[:product_id]
            product_id = params[:product_id]
        elsif session[:product_id]
            product_id = session[:product_id]
        end
        @cart_product = CartProduct.where("cart_id =? and product_id =?",session[:cart_id],product_id)
        @return_url = (request.env["HTTP_REFERER"]).gsub(/\?.*/,'')
        
        product = @cart_product.first()
        if params[:AddToCart].nil?
            #logger.debug "Quantity **** #{params[:cart_product][:quantity]}"
            
            product.update_columns(:quantity => params[:cart_product][:quantity])
            respond_with_bip product
        else
            if !product.quantity.nil?
                product.quantity = product.quantity + 1
            else
                product.quantity = 1
            end
            
            product.product_price = product.product.price * product.quantity
            logger.warn "Price **** #{product.product_price}"
            product.update_columns(:quantity => product.quantity, :product_price => product.product_price)
        logger.debug "Wishlist **** #{params[:wishlist_item]}"
                    if params[:wishlist_item].present?
                        wishlist_item = WishlistItem.find(params[:wishlist_item])
                        wishlist_item.delete
                    end
            respond_with product
        end
        
        if session[:coupon]
             coupon = Coupon.find_by_coupon_code(session[:coupon])
             if coupon.present?
                 @coupon = coupon
                    params[:coupon] = coupon.coupon_code
             end
         end
        
        
#             respond_to do |format|
#                 if product.update_columns(:quantity => product.quantity)
#                     if session[:coupon]
#                     coupon = Coupon.find_by_coupon_code(session[:coupon])
#                     if coupon.present?
#                         @coupon = coupon
#                         params[:coupon] = coupon.coupon_code
           
#                     end
#                 end
#                     format.html { redirect_to cart_products_path }
#                     format.json { respond_with_bip(cart_products_path) }
#                 else
#                     format.html { render @return_url }
#                     format.json { respond_with_bip(cart_products_path) }
#                 end
#             end
#             if product.update_columns(:quantity => product.quantity)
#                 if session[:coupon]
#                     coupon = Coupon.find_by_coupon_code(session[:coupon])
#                     if coupon.present?
#                         @coupon = coupon
#                         params[:coupon] = coupon.coupon_code
           
#                     end
#                 end
#                 redirect_to cart_products_path, notice: "Successfully update the quantity"
#             else
#                 #render :back, alert: "Unable to process your request"
#                 render @return_url, alert: "Unable to process your request"
#             end
       
        
    end
    
    def destroy
         if session[:coupon]
                
            coupon = Coupon.find_by_coupon_code(session[:coupon])
            if coupon.present?
                @coupon = coupon
                params[:coupon] = coupon.coupon_code
           
            end
        end
        
        @cart_product = CartProduct.find(params[:id])
        @cart_products = CartProduct.where("cart_id = ?",@cart_product.cart_id)
        
        if @cart_product.destroy
            if session[:coupon_usage] 
                session[:coupon_usage] = nil
            end
            
           
            redirect_to cart_products_path, notice: "Successfully removed the item from the cart"
        else
            
        end
        
    end
    
    def show
        redirect_to cart_products_path, notice: "Successfully update the quantity"
    end
    
    private
    
    
    def create_cart
        if session[:cart_id]
            return
        else
            current_session = UserCart.create
            session[:cart_id] = Cart.last.id
        end
    end
    
    def user_product_params
        params.require(:cart_product).permit(:product_id)
    end
    
    def find_by_product_id(product_id)
        CartProduct.where("cart_id = ? and product_id =? and user_id = ?",session[:cart_id],product_id, current_user.id)
    end
    
    def validate_coupon(cart_products,coupon,session,total_price)
    # one or the other must be provided
        @return_message = view_context.validate_coupon(cart_products,coupon,session,total_price)
        if @return_message.eql?('SUCCESS')
            flash[:alert] = nil
            flash[:notice] = "Successfully applied the coupon!"
            return true;
        else
            flash[:alert] = @return_message
            return false;
        
        end
      end
    
        
end
