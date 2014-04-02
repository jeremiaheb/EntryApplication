class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_ability
    @current_ability ||= Ability.new(current_diver)
  end

  
  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = "Access denied!"
    redirect_to root_url
  end

  #if Rails.env.production?  
    #def url_for(options = nil)
      #results = super(options)
      #results.insert(0, "/RVC_Data_Entry") unless results.match /^\/RVC_Data_Entry/
      #results
    #end
  #end
end
