class AdminCartProductsController < ApplicationController
    
    before_filter :create_cart, only: [:create, :destroy]
    
    # before_action is at model level
    
    def index
        @admin_cart_products = AdminCartProduct.where("cart_id = ?",session[:cart_id])
        @total_price = ManufacturerProduct.joins(:admin_cart_products).where('cart_id = ?', session[:cart_id]).sum(:price)
    end
    
    def create
        logger.debug "Inside create"
        @admin_cart_product = AdminCartProduct.new
        @admin_cart_product.manufacturer_product_id = params[:manufacturer_product_id]
        @admin_cart_product.cart_id = session[:cart_id]
        @admin_cart_product.user_id = current_user.id
        @return_url = (request.env["HTTP_REFERER"]).gsub(/\?.*/,'')
        if @admin_cart_product.save
            redirect_to admin_cart_products_path, notice: "Successfully added the product in the cart"
        else
            #render :back, alert: "Unable to process your request"
            render @return_url, alert: "Unable to process your request"
        end
    end
    
    def destroy
        @admin_cart_product = AdminCartProduct.find(params[:id])
        if @admin_cart_product.destroy
            redirect_to admin_cart_products_path, notice: "Successfully removed the item from the cart"
        else
            
        end
        
    end
    
    private
    
    def create_cart
        if session[:cart_id]
            return
        else
            current_session = AdminCart.create
            session[:cart_id] = current_session.id
        end
    end
    
    def user_product_params
        params.require(:admin_cart_product).permit(:manufacturer_product_id)
    end
end
