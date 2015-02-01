module CartProductsHelper
    
    
    
    
    
    def calculate_total_price(cart_products)
        total_price = 0
        cart_products.each do |cart_product|
            price = cart_product.product_price
            total_price +=  price
        end
    end
    
    def delete_wishlist_item
        wishlist = Wishlist.find_by("user_id=?",current_user.id)
        wishlist_items = WishlistItem.where("wishlist_id=?",wishlist.id)
        wishlist_count = wishlist_items.count
        
    end
    
end
