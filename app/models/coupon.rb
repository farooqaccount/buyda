class Coupon < ActiveRecord::Base
    has_many :product_coupons, dependent: :destroy
    has_many :products, :through => :product_coupons
    
     
    has_many :manufacturer_coupons, dependent: :destroy
    has_many :manufacturers, :through => :manufacturer_coupons
   
    has_many :category_coupons, dependent: :destroy
    has_many :categories, :through => :category_coupons
    
    has_many :coupon_histories
    
    belongs_to :order_product
     
    validates :coupon_code, presence: true, uniqueness: true
    validates :coupon_type, presence: true
    validates :discount, presence: true
    validates :start_date, presence: true
    validates :end_date, presence: true
    
     attr_reader :product_tokens
     attr_reader :manufacturer_tokens
     attr_reader :category_tokens
     
    def product_tokens=(ids)
        self.product_ids = ids.split(",")
      end
    
    
    def manufacturer_tokens=(ids)
        self.manufacturer_ids = ids.split(",")
    end
    
     
    def category_tokens=(ids)
        self.category_ids = ids.split(",")
    end
    
end
