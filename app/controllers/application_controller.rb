class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user(reload = false)
    @current_user = nil if reload
    @current_user ||= User.where(dropbox_id: session[:dropbox_id]).first
  end
end
