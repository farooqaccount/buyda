class UserCartsController < ApplicationController
    
    def create
    end
    
    def show
        @user_cart = UserCart.find(params[:id])
    end
    
    def destroy
        @user_cart = Cart.find(session[:cart_id])
        @return_url = (request.env["HTTP_REFERER"]).gsub(/\?.*/,'')
        if @user_cart.destroy
            session[:cart_id] = nil
            session[:total_price] = nil
            session[:grand_total] = nil
            session[:coupon] = nil
            session[:discount] = nil
            session[:coupon_usage] = nil
            redirect_to pages_home_path, notice: "Successfully deleted the cart"
        else
            render @return_url, alert: "Unable to process your request"
        end
    end
    
end
