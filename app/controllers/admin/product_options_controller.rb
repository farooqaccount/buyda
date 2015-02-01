class Admin::ProductOptionsController < Admin::AdminController
    
    def index
        @product_options = ProductOption.all
    end
    
    def new
        @product_option = ProductOption.new
        
    end
    
    def create
        @product_option = ProductOption.new(product_options_params)
        if @product_option.save
            redirect_to product_options_path, notice: "Successfully added the option"
        else
            render :new
        end
    end
    
    def show
        @product_option = ProductOption.find(params[:id])
    end
    
    def edit
        @product_option = ProductOption.find(params[:id])
    end
    
   def update
      @product_option = ProductOption.find(params[:id])
      if @product_option.update(product_options_params)
           redirect_to product_option_path(@product_option.id), notice: "Successfully updated the Option"
      else
          render :edit
  end
end
    
    def destroy
        @product_option = ProductOption.find(params[:id])
        if @product_option.delete
            redirect_to product_options_path, notice: "Successfully deleted the option"
        else
            render :show
        end
    end
    
    private
    
    def product_options_params
        params.require(:product_option).permit(:name, :option_type, :sort_order, product_option_values_attributes: [:id, :name, :option_id, :sort_order])
        #params.require(:project).permit(:name, tasks_attributes: [:id, :name, :_destroy])
    end
    
            
end
