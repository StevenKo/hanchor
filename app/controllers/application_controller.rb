class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?

  before_action :set_locale

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_shopping_cart
    @shopping_cart ||= Cart.find(session[:cart_id]) if session[:cart_id]
  end

  def logged_in?
    !!current_user
  end

  def require_user
    unless logged_in?
      flash[:error] = "Must logged_in"
      redirect_to login_path
    end
  end

  def get_cart_items
    if session[:cart_id]
      @cart_items = CartItem.where("cart_id = #{session[:cart_id]}")
    else
      @cart_items = []
    end
  end

  def default_url_options(options={})
    logger.debug "default_url_options is passed options: #{options.inspect}\n"
    { locale: I18n.locale }
  end

private
  
  def set_locale
    if params[:locale] && ["en", "zh-TW"].include?( params[:locale] )
      I18n.locale = params[:locale] || I18n.default_locale
    else
      I18n.locale = extract_locale_from_accept_language_header
    end
  end

  def extract_locale_from_accept_language_header
    request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
  end
  
end
