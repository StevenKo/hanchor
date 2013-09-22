class UsersController < ApplicationController  
  def new
    @user = User.new
  end

  def create
    user = User.new(users_params)
    if user.save
      flash[:notice] = "have registered"
      session[:user_id] = user.id
      redirect_to root_path
    else
      render :new
    end
  end

  def update

  end

  private
    def users_params
      params.require(:user).permit(:name,:email, :phone, :zip_code, :country, :password, :password_confirmation)
    end
end
