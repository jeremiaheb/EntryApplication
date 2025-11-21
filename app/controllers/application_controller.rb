class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_error_context
  before_action :configure_permitted_parameters, if: :devise_controller?

  layout :determine_layout

  def current_ability
    @current_ability ||= Ability.new(current_diver)
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: "You are not authorized to see this page"
  end

  protected

  def require_manager_or_admin!
    if current_diver.admin? || current_diver.manager? || current_diver.missions_managed.any?
      true
    else
      redirect_to root_url, alert: "You are not authorized to see this page"
      false
    end
  end

  # Redirects a diver to the email confirmation page on login if they have not
  # yet confirmed their email address.
  def after_sign_in_path_for(diver)
    unless diver.email_confirmed?
      flash.clear
      return edit_diver_registration_path(with_confirmation_messages: true)
    end

    super
  end

  def determine_layout
    if devise_controller?
      "application-uswds"
    else
      "application"
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:agency, :email, :email_confirmed])
  end

  def set_error_context
    # https://github.com/fractaledmind/solid_errors?tab=readme-ov-file#usage
    Rails.error.set_context(request_url: request.original_url, params: request.filtered_parameters, session: session.to_h)
  end
end
