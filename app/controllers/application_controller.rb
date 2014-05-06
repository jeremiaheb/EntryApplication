class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :configure_permitted_parameters, if: :devise_controller?
  
  def current_ability
    @current_ability ||= Ability.new(current_diver)
  end

  
  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = "Access denied!"
    redirect_to root_url
  end
    protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) << :firstname << :lastname << :email
      devise_parameter_sanitizer.for(:account_update) << :firstname << :lastname << :email
    end

end
