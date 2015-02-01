class Admin::AttributeGroupsController < Admin::AdminController
    
    def index
        @attribute_groups = AttributeGroup.all
    end
    
    def new
        @attribute_group = AttributeGroup.new
    end
    
    def create
        @attribute_group = AttributeGroup.new(attribute_group_params)
        if @attribute_group.save
            redirect_to attribute_group_path(@attribute_group.id), notice: "Sucessfully added the attribute group"
        else
            render :new
        end
    end
    
    def show
        @attribute_group = AttributeGroup.find(params[:id])
    end
    
    def edit
        @attribute_group = AttributeGroup.find(params[:id])
    end
    
    def update
        @attribute_group = AttributeGroup.find(params[:id])
        if @attribute_group.update(attribute_group_params)
            redirect_to attribute_group_path(@attribute_group.id), notice: "Sucessfully updated the attribute group"
        else
            render :edit
        end
    end
    
    def destroy
        @attribute_group = AttributeGroup.find(params[:id])
        if @attribute_group.delete
            redirect_to attribute_groups_path, notice: "Successfully deleted the Attribute group"
        else
            render :show
        end 
    end
    
    private
    
    def attribute_group_params
        params.require(:attribute_group).permit(:name,:sort_order)
    end
    
end
