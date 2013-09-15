class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_shopping_cart
    @shopping_cart ||= Cart.find(session[:cart_id]) if session[:cart_id]
  end

  def logged_in?
    !!current_user
  end

  def get_cart_items
    if session[:cart_id]
      @cart_items = CartItem.where("cart_id = #{session[:cart_id]}")
    else
      @cart_items = []
    end
  end
  
end
