class Property < ActiveRecord::Base
    has_one :payment_detail, dependent: :destroy
    has_many :property_payment_transaction, :through => :payment_detail
    
    belongs_to :land_lord, :class_name => "User"
    belongs_to :user, :class_name => "User"
end
