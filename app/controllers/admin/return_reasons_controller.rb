class Admin::ReturnReasonsController < Admin::AdminController
    
     def index
         @return_reasons = ReturnReason.all
    end
    
    def new
        @return_reason = ReturnReason.new
    end
    
    def create
        @return_reason = ReturnReason.new(return_reason_params)
        if @return_reason.save
            redirect_to return_reason_path(@return_reason.id), notice: "Successfully added the return reason"
        else
            render :new
        end
    end
    
     def show
         @return_reason = ReturnReason.find(params[:id])
    end
    
    def edit
        @return_reason = ReturnReason.find(params[:id])
    end
    
    def update
        @return_reason = ReturnReason.find(params[:id])
        if @return_reason.update(return_reason_params)
            redirect_to return_reason_path(@return_reason.id), notice: "Successfully updated the return reason"
        else
            render :edit
        end
    end
    
    def destroy
        @return_reason = ReturnReason.find(params[:id])
        if @return_reason.delete
            redirect_to return_reasons_path, notice: "Successfully deleted the return reason"
        else
            render :show
        end
    end
    
    private
    
    def return_reason_params
        params.require(:return_reason).permit(:name)
    end
end
