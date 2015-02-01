class ProductOption < ActiveRecord::Base
    has_many :product_option_values, dependent: :destroy
    accepts_nested_attributes_for :product_option_values

    
    validates :name, presence: true
    validates :option_type, presence: true
    validates :sort_order, presence: true, uniqueness: true
    
end
