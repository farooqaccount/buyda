class WishlistsController < ApplicationController
    
    def index
        @wishlist = Wishlist.find_by("user_id=?",current_user.id)
        @wishlist_items = WishlistItem.where("wishlist_id=?",@wishlist.id)
    end
    
    def new
        
    end
    
    def create
        @wishlist = Wishlist.new
        @return_url = (request.env["HTTP_REFERER"]).gsub(/\?.*/,'')
        if !find_by_user_id(current_user.id)
            @wishlist_item = WishlistItem.new
            #@wishlist.product_id = params[:product_id]
            @wishlist.user_id = current_user.id
            if @wishlist.save
                @wishlist_item.wishlist_id = @wishlist.id
                @wishlist_item.product_id = params[:product_id]
                if @wishlist_item.save
                    redirect_to wishlists_path, notice: "Successfully added the product in the wishlist"
                else
                     render @return_url, alert: "Unable to process your request"
                end
            else
                 render @return_url, alert: "Unable to process your request"
            end
        else
            update
            #render @return_url, alert: "Product already present in the wishlist"
        end
    end
    
    def show
    end
    
    def edit
    end
    
    def update
        @wishlist = Wishlist.find_by("user_id=?",current_user.id)
        @return_url = (request.env["HTTP_REFERER"]).gsub(/\?.*/,'')
        if !find_by_product_id(@wishlist.id,params[:product_id]).exists?
            @wishlist_item = WishlistItem.new
            @wishlist_item.wishlist_id = @wishlist.id
            @wishlist_item.product_id = params[:product_id]
            if @wishlist_item.save
                redirect_to wishlists_path, notice: "Successfully added the product in the wishlist"
            else
                render @return_url, alert: "Unable to process your request"
            end
        else
            redirect_to wishlists_path, notice: "Product already exists in your wishlist"
        end
        
    end
    
    def destroy
        @wishlist_item = WishlistItem.find(params[:id])
        @return_url = (request.env["HTTP_REFERER"]).gsub(/\?.*/,'')
        if @wishlist_item.destroy
#             if !find_wishlist(@wishlist_item).exists?
#                 @wishlist = Wishlist.find(@wishlist_item.wishlist.id)
#                 if @wishlist.destroy
#                     redirect_to pages_home_path, notice: "Successfully deleted the wishlist items"
#                 end
#             end
            redirect_to wishlists_path, notice: "Successfully deleted the product from the wishlist"
        else
            render @return_url, alert: "Unable to process your request"
        end
    end
    
    private
    
    def find_by_user_id(user_id)
        Wishlist.find_by("user_id = ?",current_user.id)
    end
    
    def find_by_product_id(wishlist_id,product_id)
        WishlistItem.where("wishlist_id = ? AND product_id=?",wishlist_id,product_id)
    end
    
    def find_wishlist(wishlist_item)
        WishlistItem.where("wishlist_id = ?",wishlist_item.wishlist.id)
    end
    
end