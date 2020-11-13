class ApplicationController < ActionController::Base
  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def logged_in?
    current_user
  end
  helper_method :logged_in?

  def check_login
    unless logged_in?
      flash[:error] = "Please log in to access your account"
      redirect_to login_url # halts request cycle
    end
    # redirect_to login_url, alert: "You need to log in to view this page." if current_user.nil?
  end
end
