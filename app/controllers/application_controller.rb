class ApplicationController < ActionController::Base
  protect_from_forgery
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  def current_ability
    @current_ability ||= Ability.new(current_diver)
  end

  
  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = "Access denied!"
    redirect_to root_url
  end
    protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit({ roles: [] }, :email, :password, :password_confirmation, :username) }
      #devise_parameter_sanitizer.permit(:sign_up) << :firstname << :lastname << :email
      #devise_parameter_sanitizer.permit(:account_update) << :firstname << :lastname << :email
      devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:firstname, :lastname, :email)  }
    end

end
