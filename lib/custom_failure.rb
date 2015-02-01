class CustomFailure < Devise::FailureApp
    def redirect_url
      #return super unless [:worker, :employer, :user].include?(scope) #make it specific to a scope
       #new_user_session_url(:subdomain => 'secure')
        if URI(request.referer).path.include?('/admin')
           return admin_login_path
       else
            new_user_session_path
       end
    end

    # You need to override respond to eliminate recall
    def respond
      if http_auth?
        http_auth
      else
        redirect
      end
    end
  end