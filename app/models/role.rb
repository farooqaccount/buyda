class Role < ActiveRecord::Base
    #belongs_to :user
    has_many :permissions
    has_many :users, :through => :permissions
end
