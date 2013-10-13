class ForgotPasswordsController < ApplicationController
  
  def create
    @user = User.find_by(email: params[:email])
    if @user
      UserMailer.reset_password_email(@user).deliver
      redirect_to confirm_password_reset_path
    else
      flash[:error] = "We cannot find a user with the email"
      redirect_to forget_password_path
    end
  end

end
