class Divers::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def login_dot_gov
    auth = request.env["omniauth.auth"]

    begin
      unless auth.info.email_verified?
        flash[:alert] = "The email address '#{auth.info.email}' is not verified. Please verify it using login.gov first."
        redirect_to root_url
        return
      end

      diver = Diver.from_omniauth!(auth)
      sign_in_and_redirect diver, event: :authentication
      set_flash_message(:notice, :success, kind: "login.gov") if is_navigational_format?
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "There is no account with email '#{auth.info.email}'. Contact the NCRMP team to create your account first."
      redirect_to root_url
    end
  end

  def failure
    redirect_to root_path
  end
end