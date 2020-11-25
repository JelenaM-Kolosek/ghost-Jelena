class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    include Pundit
    before_action :authenticate_user! 
    before_action :configure_permitted_parameters, if: :devise_controller?
    protected

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:full_name])
  end
end
