class Admin::ZonesController < Admin::AdminController
    
    def index
        @zones = Zone.all
    end
    
    def new
        @zone = Zone.new
    end
    
    def create
        @zone = Zone.new(zone_params)
        if @zone.save
            redirect_to zone_path(@zone.id), notice: "Successfully added the zone"
        else
            render :new
        end
    end
    
     def show
         @zone = Zone.find(params[:id])
    end
    
    def edit
        @zone = Zone.find(params[:id])
    end
    
    def update
        @zone = Zone.find(params[:id])
        if @zone.update(zone_params)
            redirect_to zone_path(@zone.id), notice: "Successfully updated the zone"
        else
            render :edit
        end
    end
    
    def destroy
        @zone = Zone.find(params[:id])
        if @zone.delete
            redirect_to zones_path, notice: "Successfully deleted the zone"
        else
            render :show
        end
    end
    
    private
    
    def zone_params
        params.require(:zone).permit(:name, :code, :status, :country_id)
    end
    
end
