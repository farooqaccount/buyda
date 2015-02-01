class ReviewsController < ApplicationController
    
    def index
        @reviews = Review.all
       
    end
    
    def new
        @review = Review.new
        
        if params[:product_id]
            @product = Product.find(params[:product_id])    
        end
    end
    
    def create
        
        @review = Review.new(review_params)
        @review.user_id = current_user.id
        if params[:product_id]
             @product = Product.find(params[:product_id])
            @review.product_id = params[:product_id]
                  
        end
        if @review.save
            redirect_to product_path(@product.id),notice: "Successfully created the review"
        else
            render :new
        end
    end
    
    def edit
        @review = Review.find(params[:id])
    end
    
    def update
        @review = Review.find(params[:id])
        @review.user_id = current_user.id
        if @review.update
            redirect_to product_path(@product.id),notice: "Successfully created the review"
        else
            render :edit
        end
    end
    
    def destroy
        @review = Review.find(params[:id])
        if @review.destroy
            redirect_to reviews_path, notice: "Successfully deleted the review"
        else
            render :show
        end
    end
    
    private
    
    def review_params
        params.require(:review).permit(:author,:product_id,:description,:rating,:status)
    end
    
end
