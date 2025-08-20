class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_error_context
  before_action :configure_permitted_parameters, if: :devise_controller?

  layout :determine_layout

  def current_ability
    @current_ability ||= Ability.new(current_diver)
  end

  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = "Access denied!"
    redirect_to root_url
  end

  protected

  def determine_layout
    return "application-uswds" if self.class <= DeviseController

    "application"
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :email])
  end

  def set_error_context
    # https://github.com/fractaledmind/solid_errors?tab=readme-ov-file#usage
    Rails.error.set_context(request_url: request.original_url, params: request.filtered_parameters, session: session.to_h)
  end
end
