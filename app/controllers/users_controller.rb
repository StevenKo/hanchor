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

    remove_email_password_params_if_not_change

    if current_user.update(users_params)
      flash[:notice] = "Updated"
    else
      flash[:error] = "Update Fail"
    end
    redirect_to account_info_path
  end

  private
    
    def remove_email_password_params_if_not_change
      email = users_params[:email]
      params[:user].delete :email if current_user.email == email
      if params[:user][:password].blank?
        params[:user].delete :password
        params[:user].delete :password_confirmation
      end
    end

    def users_params
      params.require(:user).permit(:name, :phone, :zip_code, :country, :password, :password_confirmation, :city, :state, :shipping_address)
    end
end
