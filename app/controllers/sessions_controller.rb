class SessionsController < ApplicationController  
  def new
  end

  def create
    user = User.find_by(email: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      update_current_shopping_cart_user(user.id)
      (params[:redirect_to_cart].present?)? redirect_to(cart_index_path) : redirect_to(root_path)
    else
      flash[:error] = "Something wrong, login fail!"
      redirect_to :back
    end
  end
  
  def destroy
    session[:user_id] = nil
    flash[:notice] = "logged out"
    redirect_to root_path
  end
end
