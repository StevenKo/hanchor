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

  def update_current_shopping_cart_user user_id
    current_shopping_cart.update_attribute(:user_id, user_id) if current_shopping_cart
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
    if current_shopping_cart
      @cart_items = current_shopping_cart.cart_items.includes(:product_size, :product_color)
      return if @cart_items.blank? 
      product_ids = @cart_items.map(&:product_id)
      products = Product.includes(:thumb,:product_category).joins(:product_infos).where("product_infos.country_id = #{@country_id} and products.id in (#{product_ids.join(",")})").cart_info
      product_infos = {}
      products.each {|product| product_infos[product.id] = product}
      @cart_products = []
      product_ids.each { |id| @cart_products << product_infos[id] }
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
    if params[:locale] && ["en", "zh-TW","zh"].include?( params[:locale] )
      session[:locale] = params[:locale]
    end
    I18n.locale = session[:locale] || extract_locale_from_accept_language_header
    ["zh-TW","zh"].include?( I18n.locale.to_s )? @country_id = 1 : @country_id = 2
  end

  def extract_locale_from_accept_language_header
    request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first if request.env['HTTP_ACCEPT_LANGUAGE']
  end
  
end
