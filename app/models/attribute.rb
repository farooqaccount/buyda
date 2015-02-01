class Attribute < ActiveRecord::Base
    belongs_to :attribute_group
    
    validates :name, uniqueness:  true
    validates :sort_order, uniqueness: true
end
