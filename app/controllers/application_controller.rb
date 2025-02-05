class ApplicationController < ActionController::Base
  before_action :opened_conversations_windows
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :configure_permitted_parameters, if: :devise_controller?
  def opened_conversations_windows
    if user_signed_in?
      # opened conversations
      session[:private_conversations] ||= []
      @private_conversations_windows = Private::Conversation.includes(:recipient, :messages)
                                        .find(session[:private_conversations])
    else
      @private_conversations_windows = []
    end
  end
protected

def configure_permitted_parameters
  devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  devise_parameter_sanitizer.permit(:account_update, keys: [:name])
end

def redirect_if_not_signed_in
  redirect_to root_path if !user_signed_in?
end

def redirect_if_signed_in
  redirect_to root_path if user_signed_in?
end

end
