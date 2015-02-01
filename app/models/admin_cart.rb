class AdminCart < Cart
    has_many :admin_cart_products, dependent: :destroy
end
