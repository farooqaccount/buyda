class OrderShippingDetail < ActiveRecord::Base
    belongs_to :order
    #belongs_to :user
end
