class Cart < ActiveRecord::Base
   has_many :cart_products, dependent: :destroy
   has_one :order
    
    def clear_abandoned
        carts = Cart.where("created_at < ?", Time.now.midnight)
        carts.each do |cart|
            Cart.destroy(cart.id)
        end
    end
end
