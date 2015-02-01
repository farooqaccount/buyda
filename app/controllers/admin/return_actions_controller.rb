class Admin::ReturnActionsController < Admin::AdminController
    
    def index
        @return_actions = ReturnAction.all
    end
    
    def new
        @return_action = ReturnAction.new
    end
    
    def create
        @return_action = ReturnAction.new(return_action_params)
        if @return_action.save
            redirect_to return_action_path(@return_action.id), notice: "Successfully added the return action"
        else
            render :new
        end
    end
    
     def show
         @return_action = ReturnAction.find(params[:id])
    end
    
    def edit
        @return_action = ReturnAction.find(params[:id])
    end
    
    def update
        @return_action = ReturnAction.find(params[:id])
        if @return_action.update(return_action_params)
            redirect_to return_action_path(@return_action.id), notice: "Successfully updated the return action"
        else
            render :edit
        end
    end
    
    def destroy
        @return_action = ReturnAction.find(params[:id])
        if @return_action.delete
            redirect_to return_actions_path, notice: "Successfully deleted the return action"
        else
            render :show
        end
    end
    
    private
    
    def return_action_params
        params.require(:return_action).permit(:name)
    end
end
