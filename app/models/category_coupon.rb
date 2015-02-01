class CategoryCoupon < ActiveRecord::Base
     belongs_to :category
     belongs_to :coupon
    
end
