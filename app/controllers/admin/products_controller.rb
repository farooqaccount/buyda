class Admin::ProductsController < Admin::AdminController
    include ApplicationHelper
    before_filter :authenticate_user!    
    before_action :find_product, only: [:show, :edit, :update, :destroy,:show_product]
  
    def find_product
        @product = Product.find_by_permalink(params[:id])
    end    
    
  def index
      @products = Product.all
      respond_to do |format|
        format.html
          format.json { render :json => @products.map(&:attributes) }
      end
  end
    
    def new
        @product = Product.new
        @review = Review.new
    end
    
    def create
       #rails 3
       # @product = Product.new(params[:product])
       #rails 4
        @product = Product.new(product_params) # here we are passing the parameters from the view product_params is a private method
        if @product.save
            redirect_to product_path(@product), notice: "Successfully added product" # redirecting to the show page and also providing a notice since it is success and not a error
           
        else
            render :new
        end
    end
    
    def show
        @review = Review.new
        
       # end
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
    
    def edit
       
    end
    
    def update
        logger.debug @product.active_from.inspect
        logger.debug @product.updated_at.inspect
        if @product.update(product_params)
            redirect_to product_path(@product), notice: "Sucessfully updated the product"
        else
            render :edit
        end
    end
    
    def destroy
        
        if @product.destroy
            redirect_to products_path, notice: "Successfully deleted the product"
        else
            render :show
        end
    end

    private
        
    def product_params
        params.require(:product).permit(:name, :description, :manufacturer_id, :category_id, :title, :price, :in_stock, :reduce_stock, :require_shipping, :manufactuering_date, :active_from, :user_id,:quantity)
        
    end
    
    
end
