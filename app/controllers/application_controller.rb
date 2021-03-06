class ApplicationController < ActionController::Base
  protect_from_forgery

  private
  def authenticate_admin!
    begin
      redirect_to :back, alert: 'You must be admin to do this' unless user_signed_in? and current_user.is_admin?
    rescue ActionController::RedirectBackError
      redirect_to root_path
    end
  end

  before_filter :instantiate_controller_and_action_names
 
  def instantiate_controller_and_action_names
      @current_action = action_name
      @current_controller = controller_name
  end
  
end
