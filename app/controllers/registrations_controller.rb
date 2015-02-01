class RegistrationsController < Devise::RegistrationsController
    
    #before_filter :authenticate_user!
    
    def edit
        logger.debug "Inside edit*****************"
        if current_user && current_user.roles.collect{|rol| rol.name}.include?("administrator")
            
       logger.debug "What is the  ** #{admin_registrations_edit_path}"
            redirect_to admin_registrations_edit_path
       else
            super
       end
    end
    
    private
 
    def sign_up_params
        params.require(:user).permit(:first_name, :last_name, :user_name, :email, :password, :password_confirmation,:subscribe_newsletter,:phone_number)
    end
 
    def account_update_params
        params.require(:user).permit(:first_name, :last_name, :user_name, :email, :password, :password_confirmation, :current_password,:subscribe_newsletter,:phone_number)
  end
    
#     def after_sign_up_path_for(resource)
#       after_sign_in_path_for(resource)
#     end
    
end
