class Admin::OrderStatusesController < Admin::AdminController
    
    def index
        @order_statuses = OrderStatus.all
    end
    
    def new
        @order_status = OrderStatus.new
    end
    
    def create
        @order_status = OrderStatus.new(order_status_params)
        if @order_status.save
            redirect_to order_status_path(@order_status.id), notice: "Successfully added the order status"
        else
            render :new
        end
    end
    
     def show
         @order_status = OrderStatus.find(params[:id])
    end
    
    def edit
        @order_status = OrderStatus.find(params[:id])
    end
    
    def update
        @order_status = OrderStatus.find(params[:id])
        if @order_status.update(order_status_params)
            redirect_to order_status_path(@order_status.id), notice: "Successfully updated the order status"
        else
            render :edit
        end
    end
    
    def destroy
        @order_status = OrderStatus.find(params[:id])
        if @order_status.delete
            redirect_to order_statuses_path, notice: "Successfully deleted the order status"
        else
            render :show
        end
    end
    
    private
    
    def order_status_params
        params.require(:order_status).permit(:name, :is_default,:send_email)
    end
end
