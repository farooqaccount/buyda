class Admin::ReturnStatusesController < Admin::AdminController
    def index
        @return_statuses = ReturnStatus.all
    end
    
    def new
        @return_status = ReturnStatus.new
    end
    
    def create
        @return_status = ReturnStatus.new(return_status_params)
        if @return_status.save
            redirect_to return_status_path(@return_status.id), notice: "Successfully added the return status"
        else
            render :new
        end
    end
    
     def show
         @return_status = ReturnStatus.find(params[:id])
    end
    
    def edit
        @return_status = ReturnStatus.find(params[:id])
    end
    
    def update
        @return_status = ReturnStatus.find(params[:id])
        if @return_status.update(return_status_params)
            redirect_to return_status_path(@return_status.id), notice: "Successfully updated the return status"
        else
            render :edit
        end
    end
    
    def destroy
        @return_status = ReturnStatus.find(params[:id])
        if @return_status.delete
            redirect_to return_statuses_path, notice: "Successfully deleted the return status"
        else
            render :show
        end
    end
    
    private
    
    def return_status_params
        params.require(:return_status).permit(:name, :is_default)
    end
end
