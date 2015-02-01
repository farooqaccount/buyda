class Order < ActiveRecord::Base
    
    has_many :order_products, dependent: :destroy
    has_many :order_histories, dependent: :destroy
    has_many :order_statuses, :through => :order_histories
    
    has_one :order_shipping_detail, dependent: :destroy
    has_one :coupon_history, dependent: :destroy
    accepts_nested_attributes_for :order_shipping_detail, :allow_destroy => true
    
    
    belongs_to :order_status
    belongs_to :cart
    belongs_to :user
    
    
    
    before_save :generate_invoice_no
    before_save :update_order_status
    
    after_save :update_order_products
    
    after_save :update_order_history
    #after_save :delete_cart
    after_save :update_coupon_history
    
    attr_accessor :card_number, :card_verification, :card_expires_on, :card_type, :first_name, :last_name, :coupon
    
   
    #validate :validate_card, :on => :create
    
#     def no_organisation(attributes)
#         attributes[:coupon_id].blank?
#     end
    
    def purchase
          response = GATEWAY.purchase(price_in_cents, credit_card, purchase_options)
          transactions.create!(:action => "purchase", :amount => price_in_cents, :response => response)
          #UserMailer.ordered("google.com", response.params.to_s, User.find(cart.user_id), cart).deliver
          cart.update_attribute(:purchased_at, Time.now) if response.success?
          response.success?
  end
    
    def update_order_status
        self.order_status_id = OrderStatus.find_by_name("Pending").id
    end
    
    def generate_invoice_no
        if Order.count > 0
            self.invoice_no = Order.last.invoice_no + 1
        else
            self.invoice_no = 5000;
        end
    end
    
    def update_order_products
        user_products = CartProduct.where("cart_id = ?", self.cart_id)
        user_products.each do |user_product|
            OrderProduct.create(:order_id => self.id, :product_id => user_product.product_id, :user_id => self.user_id, :quantity => user_product.quantity, :discounted_price => user_product.product_price)
            
            product = Product.find(user_product.product_id)
            
            if !product.quantity.nil?
                new_quantity = product.quantity - user_product.quantity
            else
                new_quantity = 0
            end
            if new_quantity == 0 && product.reduce_stock
                product.update(:quantity => new_quantity, :in_stock => false)
            elsif product.reduce_stock
                product.update(:quantity => new_quantity)
            else
                # Do nothing, do not reduce the quantity
            end
        end
        
    end
    
       
    def update_order_history
        order = Order.find_by_id(self.id)
        OrderHistory.create(:order_id => order.id, :order_status_id => order.order_status_id)
    end
    
     def update_coupon_history
         if self.coupon.present?
             order = Order.find_by_id(self.id)
             amount = order.total - order.discounted_total
             coupon = Coupon.find_by_coupon_code(self.coupon)
             CouponHistory.create(:order_id => self.id, :user_id => self.user_id, :coupon_id =>coupon.id,:amount => amount)
         end    
                  
    end
    
    def delete_cart
        #cart = Cart.find_by_id(self.cart_id)
        Cart.destroy(self.cart_id)
    end
    
    def self.get_total_customers
        #An array of multiple data entries
        @customers = Order.pluck(:user_id) 

        #extracts **activity** for each entry in the array @customers, and returns only the 
        #ones which are unique 

        @unique_customers = @customers.uniq.count
    end
    
    private
    
    def validate_card
    unless credit_card.valid?
      credit_card.errors.full_messages.each do |message|
        errors.add_to_base message
      end
    end
  end
  
  def credit_card
    credit_card ||= ActiveMerchant::Billing::CreditCard.new(
      :type               => card_type,
      :number             => card_number,
      :verification_value => card_verification,
      :month              => card_expires_on.month,
      :year               => card_expires_on.year,
      :first_name         => first_name,
      :last_name          => last_name
    )
  end
end
