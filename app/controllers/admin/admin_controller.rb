class Admin::AdminController < ApplicationController
  layout 'admin/admin'
  helper_method :current_admin
  before_action :authenticate

  def index
  end

  def access_denied
    flash[:error] = "You don't have permission! "
    redirect_to admin_login_path
  end

  def require_admin
    access_denied unless current_admin && current_admin.admin?
  end

  def current_admin
    @current_admin ||= User.find(session[:admin_id]) if session[:admin_id]
  end

  def authenticate
    if session[:admin_id] && session[:last_seen]
      session[:admin_id] = nil if session[:last_seen] < 1.hour.ago
    end
    require_admin
    session[:last_seen] = Time.now
  end

end
