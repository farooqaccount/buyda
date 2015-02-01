class Admin::CountriesController < Admin::AdminController
    
    def index
        @countries = Country.all
    end
    
    def new
        @country = Country.new
    end
    
    def create
        @country = Country.new(country_params)
        if @country.save
            redirect_to country_path(@country.id), notice: "Successfully added the country"
        else
            render :new
        end
        
    end
    
    def show
        @country = Country.find(params[:id])
    end
    
    def edit
        @country = Country.find(params[:id])
    end
    
    def update
        @country = Country.find(params[:id])
        if @country.update(country_params)
            redirect_to country_path(@country.id), notice: "Successfully updated the country"
        else
            render :edit
        end
    end
    
    def destroy
        @country = Country.find(params[:id])
        if @country.delete
            redirect_to countries_path, notice: "Successfully deleted the country"
        else
            render :show
        end
    end
    
    private
    
    def country_params
        params.require(:country).permit(:name, :iso_code_2, :iso_code_3, :address_format, :postcode_required, :status)
    end
    
end
