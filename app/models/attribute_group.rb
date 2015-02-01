class AttributeGroup < ActiveRecord::Base
    #has_many :association_name, foreign_key: "key_name", class_name: "ModelClass" since it threw an error for using association attributes
    has_many :product_attributes, class_name: "Attribute"
    
    validates :name, uniqueness: true
    validates :sort_order, uniqueness: true
    
end
