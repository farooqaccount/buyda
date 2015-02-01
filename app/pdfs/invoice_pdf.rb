class InvoicePdf < Prawn::Document
    require "prawn/table"
    def initialize(order)
        super()
        @order = order
        order_header
        order_details
        order_products
    end
    
    def order_header
        text "Order Invoice Number #{@order.invoice_no}"
    end
    
    def order_details
    end
    
    def order_products
    end
end