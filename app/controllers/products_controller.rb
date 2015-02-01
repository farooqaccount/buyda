class ProductsController < ApplicationController
    include ApplicationHelper
    before_action :find_product, only: [:show_product]
  
    def find_product
        @product = Product.find_by_permalink(params[:id])
    end    
    
     
    def show_product
        @review = Review.new
        #is_present = Trackable.where("user_id =? AND product_id=?",current_user.id,@product.id)
        #if is_present.count = 0
            if current_user
                Trackable.create(:user_id => current_user.id,:product_id => @product)
            end
       # end
    end
    
        
end
