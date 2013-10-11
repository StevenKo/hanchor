class CartController < ApplicationController
  before_action :require_user, only: [:index, :checkout]
  before_action :get_cart_items, only: [:index,:checkout]

  def index
  end

  def add_item_to_cart
    product = Product.find(params[:product])
    item = CartItem.new(params.require(:cart_item).permit(:product_color_id,:product_size_id))
    item.quantity = params[:quantity]
    item.product = product
    item.price = product.product_infos[@local_index].price
    
    if current_shopping_cart
      item.cart = current_shopping_cart
    else
      cart = Cart.create_new_cart session[:user_id]
      session[:cart_id] = cart.id
      item.cart = cart
    end

    if item.save
      flash[:notice] = "恭喜你，成功加入購物車了！"
    else
      flash[:error] = "對不起，無法加入購物車"
    end

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
      flash[:error] = "There is nothing in shipping"
      redirect_to root_path
    end
  end
end
