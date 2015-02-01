class Admin::AdminController < ActionController::Base
    
    layout 'layouts/admin'
    include CartProductsHelper
    
    before_filter {|c| Authorization.current_user = c.current_user} # This is for the declarative authorization
    
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
    
    before_filter :configure_permitted_parameters, if: :devise_controller?
    
    #before_filter :require_login
    
    before_filter :load_categories, :new_arrivals
    
    protected
    
      def authenticate_user!
          logger.debug "I am in admin authenticate user"
        if current_user
          super
        else
            logger.debug "I am in admin authenticate user else "
            redirect_to admin_login_path, :notice => 'You need to sign in or sign up before continuing.'
          ## if you want render 404 page
          ## render :file => File.join(Rails.root, 'public/404'), :formats => [:html], :status => 404, :layout => false
        end
      end
      

      def configure_permitted_parameters
        devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:user_name, :first_name, :last_name, :email, :password, :password_confirmation, :remember_me,:subscribe_newsletter,:phone_number) }
        devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :user_name, :email, :password, :remember_me) }
        devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:user_name, :email, :password, :password_confirmation, :current_password,:subscribe_newsletter,:phone_number) }
      end
        
#    def after_sign_out_path_for(resource_or_scope)
#        new_user_session_path
#    end
            
#    def after_sign_in_path_for(resource_or_scope)
#        pages_home_path
#     end
   
#     def after_account_update_path_for(resource_or_scope)
#        pages_home_path
#     end

       
    def require_login
        unless current_user
            return admin_login_path
        end
    end
            
    def load_categories
        @categories ||= Category.all
    end
            
    def new_arrivals
        @new_arrivals = Product.order('created_at ASC').limit(6)
        
    end
            # Declarative Authorization method
            def permission_denied
                redirect_to root_url, notice: 'Oops! page doesnt exists'
            end
        
end
