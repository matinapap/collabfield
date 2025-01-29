class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def google_oauth2
      handle_auth "Google"
    end
  
    def facebook
      handle_auth "Facebook"
    end
  
    def twitter
      handle_auth "Twitter"
    end
  
    def failure
      redirect_to root_path
    end
  
    private
  
    def handle_auth(kind)
      @user = User.from_omniauth(request.env["omniauth.auth"])
      if @user.persisted?
        sign_in_and_redirect @user, event: :authentication
        flash[:notice] = "Successfully signed in with #{kind}!" if is_navigational_format?
      else
        redirect_to new_user_registration_url
      end
    end
  end
  