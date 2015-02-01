class Category < ActiveRecord::Base
    
    #1 Callback methods
    
    #2 Asscociations
    has_many :subcategories, dependent: :destroy
    has_many :products
    
    has_many :category_coupons
    has_many :coupons, :through => :category_coupons
    
    has_ancestry
    
   
    #3 validations
    
    validates :name, :presence => true, :uniqueness => {:scope => :ancestry}
    validates_presence_of :description
    validates :is_active, :presence => true
    validates_length_of :title, :minimum => 3, :maximum => 20
    
    # Scopes
    #scope :with_cheap_products, joins(:products) & Product.cheap
    
    def self.arrange_as_array(options={}, hash=nil)                                                                                                                                                            
    hash ||= arrange(options)

    arr = []
    hash.each do |node, children|
      arr << node
      arr += arrange_as_array(options, children) unless children.nil?
    end
    arr
  end

  def name_for_selects
    "#{'-' * depth} #{name}"
  end

  def possible_parents
    parents = Category.arrange_as_array(:order => 'name')
    return new_record? ? parents : parents - subtree
  end
 
end
