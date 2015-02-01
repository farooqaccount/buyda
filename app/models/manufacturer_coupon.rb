class ManufacturerCoupon < ActiveRecord::Base
     belongs_to :manufacturer
     belongs_to :coupon
    
    
end
