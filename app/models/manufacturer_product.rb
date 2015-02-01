class ManufacturerProduct < ActiveRecord::Base
    has_many :admin_cart_products
    belongs_to :manufacturer
    belongs_to :category
    
end
