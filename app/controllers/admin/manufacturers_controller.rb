class Admin::ManufacturersController < Admin::AdminController
    
    # render 'layout' => "products" -> This is used if the manufactirer module has to use a different layout
    def index
        @manufacturers = Manufacturer.all
        respond_to do |format|
            format.html
            format.json { render :json => @manufacturers.map(&:attributes) }
        end
    end
    
    def new
        @manufacturer = Manufacturer.new
    end
    
    def create
        @manufacturer = Manufacturer.new(manufacturer_params)
        if @manufacturer.save
            redirect_to manufacturer_path([@manufacturer.id]), notice: "Sucessfully Added the Manufacturer"
             
        else
            render :new
            # render :new, :layout => "products" - > This is done if we have to render a different layout on error
        end
    end
    
    def show
        @manufacturer = Manufacturer.find(params[:id])
        @manufacturer_products = ManufacturerProduct.where("manufacturer_id = ?",params[:id])
        # render :layout => "products" - > This is the way to render a different layout when successfully added or show product
    end
    
    def edit
         @manufacturer = Manufacturer.find(params[:id])
    end
    
    def update
        @manufacturer = Manufacturer.find(params[:id])
        if @manufacturer.update(manufacturer_params)
            redirect_to manufacturer_path(@manufacturer.id), notice: "Successfully Update"
        else
            render :edit
        end
    end
    
    def destroy
        @manufacturer = Manufacturer.find(params[:id])
        if @manufacturer.destroy
            redirect_to manufacturers_path, notice: "Successfully deleted the manufacturer"
        else
            render :show
        end
    end
    
    private
    
    def manufacturer_params
        params.require(:manufacturer).permit(:name, :poc, :website,manufacturer_products_attributes: [:id, :name, :description, :price, :title, :in_stock, :reduce_stock, :require_shipping,:manufactuering_date, :active_from, :user_id, :manufacturer_id, :category_id])
    end
end
