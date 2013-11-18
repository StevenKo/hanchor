class Admin::SessionsController < Admin::AdminController

  skip_before_action :authenticate

  def new
  end

  def create
    user = User.find_by(name: params[:session][:name])
    if user && user.authenticate(params[:session][:password])
      session[:admin_id] = user.id
      require_admin
      flash[:notice] = "Welcome, #{user.name} logged in"
      redirect_to admin_path
    else
      flash[:error] = "something wrong"
      redirect_to admin_login_path
    end
  end

  def destroy
    session[:admin_id] = nil
    flash[:notice] = "logged out"
    redirect_to admin_login_path
  end

end
