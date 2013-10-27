class UsersController < ApplicationController  
  def new
    @user = User.new
  end

  def create
    @user = User.new(users_params)
    if @user.save
      UserMailer.register_email(@user).deliver
      flash[:notice] = "have registered"
      session[:user_id] = @user.id
      update_current_shopping_cart_user(@user.id)      
      (params[:redirect_to_cart].present?)? redirect_to(cart_index_path) : redirect_to(root_path)
    else
      render :new
    end
  end

  def update

    remove_password_params_if_not_change

    if current_user.update(users_params)
      flash[:notice] = "Updated"
    else
      flash[:error] = "Update Fail"
    end
    redirect_to account_info_path
  end

  private
    
    def remove_password_params_if_not_change

      if params[:user][:password].blank?
        params[:user].delete :password
        params[:user].delete :password_confirmation
      end
    end

    def users_params
      params.require(:user).permit(:email, :name, :phone, :zip_code, :country, :password, :password_confirmation, :city, :state, :shipping_address)
    end
end
