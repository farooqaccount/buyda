class Product < ActiveRecord::Base
    
    # attr_assecible is used in Rails 3 if the rails 4 product_params is not used
    
    #1 Callback methods are mentioned
    
    #2 Associations
    #    has
    #    belongs
    has_and_belongs_to_many :sub_categories
    
    has_many :product_coupons, dependent: :destroy
    has_many :coupons, :through => :product_coupons
    
    has_many :cart_products, dependent: :destroy
    has_many :order_products, dependent: :destroy
    has_many :reviews
    has_many :trackables
    has_many :users, :through => :trackables
    has_many :wishlist_items, dependent: :destroy
    belongs_to :manufacturer
    belongs_to :category
    
   
    
    #3 Validations
    #    inbuilt validations
    #    custom validations
    
    validates :name, :presence => true # This is a new type of syntaq
    validates_presence_of :description
    validates :price, :numericality => true
    validates_length_of :title, :minimum => 3, :maximum => 20
    # validates :title, length: {in: 3..20}
    # validates :title, length: {minimum: 3}
    
    #4 callback method logic i.e callback definitions
    before_save :generate_permalink
    #5 General methods
    
    def seo_title
        "#{name} - #{title} - #{price}$"
    end
    
    
    #7 self referential methods
    def self.sort_option(option)
        if option == "1"
            order("name")
        elsif option == "2"
            order("name")
        elsif option == "3"
            order("name DESC")
        elsif option == "4"
            order("price")
        elsif option == "5"
            order("price DESC")
        elsif option == "6"
            includes(:reviews).order("reviews.rating DESC")
        elsif option == "7"
            includes(:reviews).order("reviews.rating")
        end
    end

    def self.available(avail)
        where("in_stock=?", avail)
    end
    
    def self.search_price(min,max)
        if min.present? && max.present?
            where("price BETWEEN ? AND ?", min, max).order(:price)
        elsif min.present? && !max.present?
            where("price >= ?",min).order(:price)
        elsif max.present? && !min.present?
            where("price <= ?",max).order(:price)
        end
   end
    #6 scopes
    scope :available_stock, lambda {|avail| available(avail)}
    scope :cheaper_than, lambda {|price| where("price < ?",price)}
    scope :sort_options, lambda {|option| sort_option(option)}
    scope :products_per_page, lambda {|page,no_of_records| page(page).per_page(no_of_records.to_i)}
    scope :search_by_price, lambda {|min,max| search_price(min,max)}
    
    
#     def self.cheap_than(price)
    #         where("products.price < ?",price)
#     end

#     scope :cheap, cheap_than(12)
    
    def to_param
        permalink
    end
    
    #8 private methods
    private
    def generate_permalink
        self.permalink = self.name.parameterize
    end
    
end
