class SessionsController < Devise::SessionsController
    
    def destroy
        signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(current_user))
        set_flash_message :notice, :signed_out if signed_out && is_flashing_format?
        if current_user && current_user.roles.collect{|rol| rol.name}.include?("administrator")
           return admin_login_path
       else
           return new_user_session_path
       end
    end
    
end