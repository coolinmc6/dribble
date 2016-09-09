class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # these items added for Devise
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
  	# sign_up and account_update are the things that I am adding name to (as part of authentication)
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
end
