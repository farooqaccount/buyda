class PagesController < ApplicationController
    
    
    DEFAULT_NO_OF_RECORDS = 5
    
    def dashboard
       
    end
    
    def home
        
        @categories = Category.order("name DESC")
        @products = Product.order("created_at DESC")
        
        if current_user
            @recently_viewed = current_user.trackables.limit(10)
        end
        
        if session[:cart_id]
            return
        else
            if current_user
                cart_product = CartProduct.where("user_id=?",current_user.id)
                if cart_product.present? && cart_product.count > 0
                    session[:cart_id] = cart_product[0].cart_id
                else
                    return
                end
            end
        end
    end
    
    def category_products
        @category = Category.find(params[:category_id])
        logger.debug "Option **** #{params[:option]}"
        if params[:show].present?
            no_of_records = params[:show]
        else
            no_of_records = DEFAULT_NO_OF_RECORDS
        end
    
        if params[:option].present?

            if params[:availability].present?
                if params[:search_min].present? || params[:search_max].present?
                    @products = @category.products.available_stock(params[:availability]).search_by_price(params[:search_min],params[:search_max]).sort_options(params[:option]).products_per_page(params[:page],no_of_records)
                else
                    @products = @category.products.available_stock(params[:availability]).sort_options(params[:option]).products_per_page(params[:page],no_of_records)
                end

            else
                @products = @category.products.sort_options(params[:option]).products_per_page(params[:page],no_of_records)
            end
        else
            if params[:availability].present?
                if params[:search_min].present? || params[:search_max].present?
                    @products = @category.products.available_stock(params[:availability]).search_by_price(params[:search_min],params[:search_max]).sort_options(1).products_per_page(params[:page],no_of_records)
                else
                    @products = @category.products.available_stock(params[:availability]).sort_options(1).products_per_page(params[:page],no_of_records)
                end

            else
              
                if params[:search_min].present? || params[:search_max].present?
                    @products = @category.products.search_by_price(params[:search_min],params[:search_max]).sort_options(1).products_per_page(params[:page],no_of_records)
                else
                    @products = @category.products.products_per_page(params[:page],no_of_records)
                end
            end
        
    end
#         if params[:option].present?
#             @products = @category.products.sort_options(params[:option]).products_per_page(5)
#             if params[:availability].present?
#                 @products = @category.products.sort_options(params[:option]) & Product.availability(params[:availability])
#             end
#            @products = @products.products_per_page(5)
#         else
#             @products = @category.products.products_per_page(5)
#        end
        
#         if params[:option].present?
#             logger.debug "In Option present **** #{params[:option]}"
#                 if params[:option] == "1"
#                     @products = Product.where("category_id =? ", params[:category_id]).page(params[:page]).per_page(5)
#                 elsif params[:option] == "2"
#                     logger.debug "In Option 2 **** #{params[:option]}"
#                     @products = Product.where("category_id =? ", params[:category_id]).order(:name).page(params[:page]).per_page(5)
#                 elsif params[:option] == "3"
#                     @products = Product.where("category_id =? ", params[:category_id]).order("name DESC").page(params[:page]).per_page(5)
#                 elsif params[:option] == "4"
#                     @products = Product.where("category_id =? ", params[:category_id]).order("price").page(params[:page]).per_page(5)
#                 elsif params[:option] == "5"
#                     @products = Product.where("category_id =? ", params[:category_id]).order("price DESC").page(params[:page]).per_page(5)
#                 elsif params[:option] == "6"
#     #@products = Product.joins("left outer join reviews as rev on products.id = rev.product_id").where("category_id=?",13).order("rev.rating")
#     @products = Product.includes(:reviews).where('category_id = ? ', params[:category_id]).order("reviews.rating DESC").page(params[:page]).per_page(5)
#                 elsif params[:option] == "7"
#     @products = Product.includes(:reviews).where('category_id = ? ', params[:category_id]).order("reviews.rating").page(params[:page]).per_page(5)
#             end
#         else
#             @products = Product.where("category_id =?", params[:category_id]).page(params[:page]).per_page(5)
#         end
       
    end
    
    def admin_home
        @manufacturer_products = ManufacturerProduct.order("created_at DESC")
    end
    
    def about
    end
    
    def contact
    end
    
    def help
    end
    
    def terms
    end
    
    def privacy
    end
    
    def documentation
    end
end
