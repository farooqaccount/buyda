class AdminCartProduct < ActiveRecord::Base
    belongs_to :user
    belongs_to :admin_cart
    belongs_to :manufacturer_product
end
