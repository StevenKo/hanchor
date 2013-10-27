# encoding: utf-8
class CartController < ApplicationController
  before_action :require_user, only: [:checkout]
  before_action :get_cart_items, only: [:index,:checkout]

  def index
    unless logged_in?
      flash[:error] = "Must logged_in"
      redirect_to login_path(cart: "index")
    end
  end

  def add_item_to_cart
    product = Product.find(params[:product])
    item = CartItem.new(params.require(:cart_item).permit(:product_color_id,:product_size_id))
    item.quantity = params[:quantity]
    item.product = product
    info = product.product_infos.where("country_id = #{@country_id}").select("special_price,price")[0]
    (info.special_price.present?) ?  item.price = info.special_price : item.price = info.price
    
    if current_shopping_cart
      item.cart = current_shopping_cart
    else
      cart = Cart.create(user_id: session[:user_id])
      session[:cart_id] = cart.id
      item.cart = cart
    end
    item.save

    redirect_to products_show_path(product.product_category.name_en, product)
  end

  def remove_cart_item
    CartItem.delete(params[:item_id])
    redirect_to :back
  end

  def change_cart_item_quantity
    item = CartItem.find(params[:id])
    item.quantity = params[:cart_item][:quantity]
    unless item.save
      flash[:error] = "錯誤發生，麻煩你再重試一次，或聯絡我們！"
    end
    redirect_to cart_index_path
  end

  def checkout
    if (@cart_items.present?)
      @order = Order.new
      shipping_array = YAML::load(@cart_products[0].shipping)
      @cart_products.each do |p|
        shipping_array = shipping_array & YAML::load(p.shipping)
      end
      @shippings = ShippingCost.where(id: shipping_array)
      @shippings_selector = @shippings.map{ |s| ["#{s.description}($NT#{s.cost})",s.id]}
    else
      flash[:error] = "There is nothing in shopping cart!"
      redirect_to root_path
    end
  end

  def check_out_shipping
    @shipping = ShippingCost.find(params[:shipping_cost_id])
  end
end
