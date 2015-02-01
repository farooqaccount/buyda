class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable
    #belongs_to :role
    has_one :profile
    has_many :admin_cart_products
    has_many :cart_products
    has_many :orders
    
    has_many :properties, :class_name => "Property", :foreign_key => "land_lord_id"
    has_many :user_properties,   :class_name => "Property", :foreign_key => "user_id"
    has_one :wishlist, dependent: :destroy
    has_many :wishlist_items, :through => :wishlist
    
    has_many :trackables
    has_many :products, :through => :trackables
    
    has_many :permissions
    has_many :roles, :through => :permissions
    
    accepts_nested_attributes_for :roles
    
    #has_many :order_shipping_details
    
    #before_create :set_default_role
    
    #validates :user_name, presence: true,
    #:uniqueness => {
    #:case_sensitive => false
     # }
    
    validates :user_name, presence: true, length: {maximum: 255}, uniqueness: { case_sensitive: false }, format: { with: /\A[a-zA-Z0-9]*\z/, alert: "must contain only letters and numbers." }
    validates :phone_number, presence: true, length: {:minimum => 10, :maximum => 15}, format: {with:  /\d[0-9]\)*\z/, alert: "Only positive number without spaces are allowed"}
    
    
      attr_accessor :login

      def self.find_first_by_auth_conditions(warden_conditions)
          conditions = warden_conditions.dup
          if login = conditions.delete(:login)
            where(conditions).where(["user_name = :value OR lower(email) = lower(:value)", { :value => login }]).first
          else
            where(conditions).first
          end
        end
    
    def role_symbols
        roles.map do |role| #use a map when we need a comman after each other
            role.name.underscore.to_sym # or we can just use role.name.to_sym
        end
    end
    
    private
      def set_default_role
        self.role ||= Role.find_by_name('registered')
          # A common misconception is that a ||= b is equivalent to a = a || b, but it behaves like a || a = b. In a = a || b, a is set to something by the statement on every run, whereas with a || a = b, a is only set if a is logically false (i.e. if it's nil or false) because || is 'short circuiting'. That is, if the left hand side of the || comparison is true, there's no need to check the right hand side
      end
    
end
