class CartProduct < ActiveRecord::Base
    belongs_to :user
    belongs_to :cart
    belongs_to :product
      
end
