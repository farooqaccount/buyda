class Zone < ActiveRecord::Base
    belongs_to :country
    
    #default_scope {order{'zones.name ASC'}}
    
    validates :name, presence: true, length: {in: 2..50}
    validates :country_id, presence: true
    validates :name, :uniqueness => {:scope => :country_id, :message => "Combination of Country and Zone name should be unique."}
end
