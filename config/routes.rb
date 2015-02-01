Rails.application.routes.draw do
    
    devise_for :users,path_names: {sign_in: "login",sign_out: "logout"}, :controllers => { registrations: 'registrations' }
       
    devise_scope :user do
      #root 'devise/sessions#new'
      #root "devise/sessions#new", :as => :login
      #match "/admin", :to => "devise/admin/sessions#new",:via => :get, :as => :login
    end
    root "pages#home"
    
#     namespace :admin do
#         resources :products, :categories, :manufacturers, :coupons, :attributes
#         resources :attribute_groups, :languages, :currencies, :stock_statuses
#     end
    
    namespace :admin do
        get "sessions/new", :as => :login
        get "pages/dashboard"
        get "pages/order_details"
        root "pages#dashboard"
        get "registrations/edit"
        
#         devise_scope :admin do
#           #root 'devise/sessions#new'
#             root "sessions#new", :as => :login
#             #match "/admin", :to => "devise/admin/sessions#new",:via => :get, :as => :login
#         end
        
        resources:products
        # Adding resources for manufacturer
        resources:manufacturers

        # Adding resources for category
        resources:categories

        # Adding resources for attribute
        resources:attributes

        # Adding resources for attribute group
        resources:attribute_groups

        # Adding resources for languages
        resources:languages

        # Adding resources for currencies
        resources:currencies

        # Adding resources for stock_statuses
        resources:stock_statuses

        # Adding resources for order_statuses
        resources:order_statuses

        # Adding resources for return_statuses
        resources:return_statuses

        # Adding resources for return_actions
        resources:return_actions

        # Adding resources for return_reasons
        resources:return_reasons

        # Adding resources for countries
        resources:countries

        # Adding resources for zones
        resources:zones

        # Adding resources for length_classes
        resources:length_classes

        # Adding resources for weight_classes
        resources:weight_classes

        # Adding resources for product_options
        resources:product_options

    end
    
    
    
    #resources:users
    #get 'categories/index'

    #get 'products/index'

    # Adding resources for reviews
    resources:reviews 
   
    # Adding resources for products
    resources:products , only: [:show_product] do
        resources:reviews
        member do
            get "show_product"
        end
    end
    
    
    # Adding resources for pages
   
        get "pages/home"
        get "pages/help"
        get "pages/about"
        get "pages/contact"
        
        get "pages/documentation"
        get "pages/privacy"
        get "pages/terms"
        get "pages/admin_home"
        get "pages/my_account"
        get "pages/category_products"
    
    # Adding resources for cart products
    resources:cart_products
    
    # Adding resource for user cart
    resources:carts
   
    # Adding resources for admin cart products
    resources:admin_cart_products
    
    # Adding resources for coupons
    resources:coupons
    
    # Adding resources for user_carts
    resources:user_carts
    
    # Adding resources for orders
    resources:orders
    
    resources :orders do
        member do
          post :generate_invoice
      end
    end

    # Adding resources for orders
    resources:order_histories
    
    # Adding resources for properties
    resources:properties
    
     # Adding resources for payment_details
    resources:payment_details
    
    #Adding resources for order products
    resources:order_products
    
    # Adding resources for wishlist
    resources:wishlists
    
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
    #root 'pages#dashboard'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
