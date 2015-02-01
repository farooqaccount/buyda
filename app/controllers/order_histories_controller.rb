class OrderHistoriesController < ApplicationController
    
    def index
    end
    
    def new
    end
    
    def create
        @order_history = OrderHistory.new(order_history_params)
        @return_url = (request.env["HTTP_REFERER"]).gsub(/\?.*/,'')
        if @order_history.save
            if @order_history.order_status.send_email || @order_history.notify
                Notifications.update_order(@order_history.order).deliver
            end
            #render @return_url, notice: "Successfully updated the History"
            
            redirect_to edit_order_path(@order_history.order.id), notice: "Successfully updated order history"
            
        else
            render @return_url, alert: "Unable to process your request"
        end
    end
    
    def show
    end
    
    def edit
    end
    
    def update
    end
    
    def destroy
    end
    
    private
    
    def order_history_params
        params.require(:order_history).permit(:order_id,:order_status_id,:notify)
    end
end
