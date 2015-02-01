class Country < ActiveRecord::Base
    has_many :zones
    
    #default_scope {order{'countries.name ASC'}}
    
    validates :name, presence: true, uniqueness: true
    validates :iso_code_2, uniqueness: true
    validates :iso_code_3, uniqueness: true
end
