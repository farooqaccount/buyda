class OrderProductsController < ApplicationController
    
    def destroy
        @order_product = OrderProduct.find(params[:id])
        @return_url = (request.env["HTTP_REFERER"]).gsub(/\?.*/,'')
       
        #@order_product.each do |ord_prod|
        if @order_product.destroy
            #redirect_to edit_order_path(@order_product.order_id), notice: "Successfully deleted the product from the order"
            redirect_to "/orders/#{@order_product.order_id}/edit#products"
            else
                render @return_url, alert: "Unable to delete the product"
            end
        #end
        
    end
end