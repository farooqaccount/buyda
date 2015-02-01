class Admin::AttributesController < Admin::AdminController
    
    def index
        @attributes = Attribute.all
    end
    
    def new
        @attribute = Attribute.new
    end
    
    def create
        @attribute = Attribute.new(attributes_params)
        if @attribute.save
            redirect_to attribute_path(@attribute.id), notice: "Successfully added the attribute"
        else
            render :new
        end
        
    end
    
    def show
        @attribute = Attribute.find(params[:id])
       #@attribute = Attribute.includes(:attribute_group).where(id: params[:id])
    end
    
    def edit
        @attribute = Attribute.find(params[:id])
    end
    
    def update
        @attribute = Attribute.find(params[:id])
        if @attribute.update(attributes_params)
            redirect_to attribute_path(@attribute.id), notice: "Successfully updated the attribute"
        else
            render :edit
        end
    end
    
    def destroy
        @attribute = Attribute.find(params[:id])
        if @attribute.delete
            redirect_to attributes_path, notice: "Successfully deleted the attribute"
        else
            render :show
        end
    end
    
    private 
    
    def attributes_params
        params.require(:attribute).permit(:name, :attribute_group_id, :sort_order)
    end
    
end
