class OrdersController < ApplicationController
  before_action :get_cart_items

  def create
    order = Order.new(order_params)
    order.user_id = current_user.id
    @cart_items.each do |cart_item|
      order_item = OrderItem.new(product_id: cart_item.product_id, quantity: cart_item.quantity, price: cart_item.price, product_size_id: cart_item.product_size_id, product_color_id: cart_item.product_color_id)
      order.order_items << order_item
    end
    order.total = sum_item_price(order)
    order.memo = params[:memo]
    order.status = "order_confirm"
    order.code = Date.today.strftime("%y%m%d") + (Order.where("created_at > ?",Date.today).size + 1).to_s.rjust(3, '0')

    if order.save
      @shopping_cart.delete
      session[:cart_id] = nil
      flash[:notice] = "恭喜你，成功購買了Hanchor的商品！"
      redirect_to result_orders_url(order: order)
    else
      flash[:error] = "錯誤發生，麻煩你再重試一次，或聯絡我們！"
      redirect_to :back
    end

    
    # return_url = result_orders_url
    # redirect_to current_shopping_cart.paypal_url(return_url)
  end

  def result
    @order = Order.find(params[:order])
  end

  private

  def order_params
    params.require(:order).permit(:shipping_name, :phone, :zip_code, :country, :city, :state, :shipping_address, :shipping_cost_id, :payment)
  end

  def sum_item_price order
    sum = 0
    order.order_items.each do |item|
      sum += (item.price * item.quantity)
    end
    sum
  end

end
