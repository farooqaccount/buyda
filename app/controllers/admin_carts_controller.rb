class AdminCartsController < ApplicationController
    
    def create
    end
    
    def show
        @admin_cart = AdminCart.find(params[:id])
    end
    
end
