class Admin::StockStatusesController < Admin::AdminController
    def index
        @stock_statuses = StockStatus.all
    end
    
    def new
        @stock_status = StockStatus.new
    end
    
    def create
        @stock_status = StockStatus.new(stock_status_params)
        if @stock_status.save
            redirect_to stock_status_path(@stock_status.id), notice: "Successfully added the stock status"
        else
            render :new
        end
    end
    
     def show
        @stock_status = StockStatus.find(params[:id])
    end
    
    def edit
        @stock_status = StockStatus.find(params[:id])
    end
    
    def update
        @stock_status = StockStatus.find(params[:id])
        if @stock_status.update(stock_status_params)
            redirect_to stock_status_path(@stock_status.id), notice: "Successfully updated the stock status"
        else
            render :edit
        end
    end
    
    def destroy
        @stock_status = StockStatus.find(params[:id])
        if @stock_status.delete
            redirect_to stock_statuses_path, notice: "Successfully deleted the stock status"
        else
            render :show
        end
    end
    
    private
    
    def stock_status_params
        params.require(:stock_status).permit(:name, :is_default)
    end
end
