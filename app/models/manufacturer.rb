class Manufacturer < ActiveRecord::Base
    has_many :products, -> {order 'name desc'}
    has_many :manufacturer_products, ->{order 'name desc'}, dependent: :destroy
    has_many :manufacturer_coupons
    has_many :coupons, :through => :manufacturer_coupons
    
    accepts_nested_attributes_for :manufacturer_products
    
    
end
