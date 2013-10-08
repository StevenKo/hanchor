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
    @order = Order.new
    ps = Product.where(id: @cart_items.map(&:product_id)).includes(:product_infos)
    shipping_array = ps[0].product_infos[@local_index].shipping
    ps.each do |p|
      shipping_array = shipping_array & p.product_infos[@local_index].shipping
    end
    @shippings = ShippingCost.where(id: shipping_array)
    @shippings_selector = @shippings.map{ |s| ["#{s.description}($NT#{s.cost})",s.id]}
  end
end
