class Admin::AdminController < ApplicationController
  layout 'admin/admin'
  before_action :require_admin, only: [:index]

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

end
