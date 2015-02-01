class ApplicationController < ActionController::Base
    include CartProductsHelper
    
    #before_filter :authenticate_user!
    before_filter {|c| Authorization.current_user = c.current_user} # This is for the declarative authorization
    
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
    
    before_filter :configure_permitted_parameters, if: :devise_controller?
    
    #before_filter :require_login
    
    before_filter :load_categories, :new_arrivals
    
    protected

#     def authenticate_user!
#             if user_signed_in?
#           super
#         else
#             redirect_to login_path, :notice => 'You need to sign in or sign up before continuing.'
#           ## if you want render 404 page
#           ## render :file => File.join(Rails.root, 'public/404'), :formats => [:html], :status => 404, :layout => false
#         end
#       end
    
      def configure_permitted_parameters
        devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:user_name, :first_name, :last_name, :email, :password, :password_confirmation, :remember_me,:subscribe_newsletter,:phone_number) }
        devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :user_name, :email, :password, :remember_me) }
        devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:user_name, :email, :password, :password_confirmation, :current_password,:subscribe_newsletter,:phone_number) }
      end
        
   def after_sign_out_path_for(resource_or_scope)
       if URI(request.referer).path.include?('/admin')
           return admin_login_path
       else
           return pages_home_path
       end
       
   end
            
   def after_sign_in_path_for(resource_or_scope)
       #pages_home_path
       if current_user && current_user.roles.collect{|rol| rol.name}.include?("administrator")
       #logger.debug "What is the resourse ** #{resource_or_scope}"
           return admin_pages_dashboard_path
       else
           return pages_home_path
       end
    end
   
    def after_account_update_path_for(resource_or_scope)
        if URI(request.referer).path.include?('/admin')
            admin_pages_dashboard_path
        else
            pages_home_path
        end
       
    end

       
    def require_login
#         @url = session[:previous_urls].reverse.first
#         if @url != nil
#             admin_login_path
#         else
#             new_user_session_path
#         end
        unless current_user
            logger.debug "Inside require login #{URI(request.referer).path.to_s}"
            if URI(request.referer).path.to_s.include?('/admin')
                logger.debug "Yes I am an admin #{URI(request.referer).path.to_s}"
                redirect_to admin_login_path
            else
                redirect_to new_user_session_path
            end
        end
        
#         unless current_user
#             if URI(request.referer).path == '/admin'
#                 return admin_login_path
#             else
#                 new_user_session_path
#             end
          
#         end
    end
            
    def convert_to_uri(uri)
      if uri.is_a?(URI::Generic)
        uri
      elsif uri = String.try_convert(uri)
        parse(uri)
      else
        raise ArgumentError,
          "bad argument (expected URI object or URI string)"
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
            
            def store_location
              session[:previous_urls] ||= []
              # store unique urls only
              session[:previous_urls].prepend request.fullpath if session[:previous_urls].first != request.fullpath && request.fullpath != "/user" && request.fullpath != "/user/login" && request.fullpath != "/" && request.fullpath != "/user/logout" && request.fullpath != "/user/join" && request.fullpath != "/user/auth/facebook/callback"
              # For Rails < 3.2
              # session[:previous_urls].unshift request.fullpath if session[:previous_urls].first != request.fullpath 
              session[:previous_urls].pop if session[:previous_urls].count > 3
            end
        
end
