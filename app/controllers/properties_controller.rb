class PropertiesController < ApplicationController
    
    def index
        @properties = Property.all
    end
    
    def new
        @property = Property.new
    end
    
    def create
        @property = Property.new(property_params)
        if @property.save
            redirect_to property_path(@property.id), notice: "Successfully created the property"
        else
            render :new
        end
        
    end
    
    def show
        @property = Property.find(params[:id])
    end
    
    def edit
        @property = Property.find(params[:id])
    end
    
    def update
        @property = Property.find(params[:id])
        if @property.update
            redirect_to property_path(@property.id), notice: "Successfully updated the property"
        else
            render :edit
        end
    end
    
    def destroy
        @property = Property.find(params[:id])
        if @property.delete
            redirect_to properties_path, notice: "Successfully deleted the property"
        else
            render :show
        end
    end
    
    private
    
    def property_params
        params.require(:property).permit(:property_code,:state_id,:district_id,:land_lord_id,:user_id,:address,:lease_start_date,:lease_end_date,:rent_amount,:remarks)
    end
    
end
