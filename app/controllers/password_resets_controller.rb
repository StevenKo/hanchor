class PasswordResetsController < ApplicationController
  
  def show
    @user = User.find_by(token: params[:id])
    unless @user
      flash[:error] = "You don't the permission"
      redirect_to invalid_token_path
      return
    end
  end

  def create
    @user = User.find_by(token: params[:token])
    if @user
      flash[:notice] = "Successfuly change the password"
      @user.update_attributes(password: params[:password], token: SecureRandom.urlsafe_base64)
      redirect_to login_path
    else
      flash[:error] = "You don't the permission"
      redirect_to forget_password_path
    end
  end

end
