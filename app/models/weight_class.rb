class WeightClass < ActiveRecord::Base
    
    validates :title, presence: true
    validates :unit, presence: true
    validates :title, uniqueness: true
    validates :title, :uniqueness => {:scope => :unit, :message => "The combination of the title and unit must be unique."}
end
