class Divers::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # See https://github.com/omniauth/omniauth/wiki/FAQ#rails-session-is-clobbered-after-callback-on-openid-providers
  skip_before_action :verify_authenticity_token, only: [:icam]

  def developer
    # Additional check to make sure this never runs in production
    unless Rails.env.development?
      head :not_found
      return
    end

    user = Diver.find_by!(email: request.env["omniauth.auth"].uid)

    set_flash_message!(:notice, :success, kind: "Developer")
    sign_in_and_redirect user, event: :authentication
  rescue ActiveRecord::RecordNotFound
    set_flash_message!(:alert, :failure, kind: "Developer", reason: "No diver with that email address exists. Please contact the NCRMP team to request an account.")
    redirect_to after_omniauth_failure_path_for(resource_name)
  end

  def icam
    user = Diver.find_by!(email: request.env["omniauth.auth"].info.email)

    set_flash_message!(:notice, :success, kind: "ICAM")
    sign_in_and_redirect user, event: :authentication
  rescue ActiveRecord::RecordNotFound
    set_flash_message!(:alert, :failure, kind: "ICAM", reason: "No diver with that email address exists. Please contact the NCRMP team to request an account.")
    redirect_to after_omniauth_failure_path_for(resource_name)
  end
end
