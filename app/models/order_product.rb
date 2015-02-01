class OrderProduct < ActiveRecord::Base
    belongs_to :order
    belongs_to :coupon
    belongs_to :product
    
        
    after_destroy :substract_discounted_total_in_order
        
    def substract_discounted_total_in_order
        order = Order.find_by_id(self.order_id)
        logger.debug "Self Product price *** #{self.product.price}"
        logger.debug "Self discounted price *** #{self.discounted_price}"
        logger.debug "Order Discounted Total **** #{order.discounted_total}"
        order_total = order.discounted_total
        if self.discounted_price.present?
            substracted_value = order_total - self.discounted_price
        else
            substracted_value = order_total - self.product.price
        end
        order.update_column("discounted_total",substracted_value)
    end
end
