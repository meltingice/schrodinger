class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :current_node, :root_node

  def current_user(reload = false)
    @current_user = nil if reload
    @current_user ||= User.where(dropbox_id: session[:dropbox_id]).first
  end

  def root_node
    return if current_user.nil?
    @root_node ||= current_user.node_root
  end

  def current_node
    return if current_user.nil? || root_node.nil?
    root_node.child_with_path(params[:path]) || root_node
  end
end
