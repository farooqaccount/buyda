class ProductOptionValue < ActiveRecord::Base
    belongs_to :product_option
    
    validates :name, presence: true
    validates :sort_order, presence: true
    validates_uniqueness_of :sort_order, :scope => [:product_option_id]
    #validates_association :option
    
        
    
end
