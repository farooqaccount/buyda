class ProductCoupon < ActiveRecord::Base
    belongs_to :product
    belongs_to :coupon
   
end
