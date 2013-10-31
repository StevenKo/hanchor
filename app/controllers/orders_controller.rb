# encoding: utf-8
class OrdersController < ApplicationController
  before_action :get_cart_items

  def create
    @order = Order.new(order_params)
    @order.user_id = current_user.id
    @cart_items.each do |cart_item|
      order_item = OrderItem.new(product_id: cart_item.product_id, quantity: cart_item.quantity, price: cart_item.price, product_size_id: cart_item.product_size_id, product_color_id: cart_item.product_color_id)
      @order.order_items << order_item
    end
    @order.total = sum_item_price(@order) + ShippingCost.find(params[:order][:shipping_cost_id]).cost if params[:order][:shipping_cost_id].present?
    @order.memo = params[:memo]
    @order.status = "order_confirm"
    @order.code = Date.today.strftime("%y%m%d") + (Order.where("created_at > ?",Date.today).size + 1).to_s.rjust(3, '0')
    @order.shipping_store = "#{params[:order][:store][:code]},#{params[:order][:store][:stroe_name]}" if params[:order][:store]

    if @order.dose_not_have_product_in_stock
      flash[:error] = @order.quantity_error_mesage(@country_id)
      redirect_to :back
    else
      if @order.save
        @order.deduct_quanitity
        if(@order.payment == "PayPal")
          return_url = result_orders_url(order: @order)
          redirect_to current_shopping_cart.paypal_url(return_url,params[:locale],payment_notifications_url,@order.id,ShippingCost.find(params[:order][:shipping_cost_id]))
        else
          @order.update_attribute("is_show",true)
          redirect_to result_orders_url(order: @order)
        end
      else
        shipping_array = YAML::load(@cart_products[0].shipping)
        @cart_products.each do |p|
          shipping_array = shipping_array & YAML::load(p.shipping)
        end
        @shippings = ShippingCost.where(id: shipping_array)
        @shippings_selector = @shippings.map{ |s| ["#{s.description}($NT#{s.cost})",s.id]}
        render 'cart/checkout'
      end
    end

    # return_url = result_orders_url
    # redirect_to current_shopping_cart.paypal_url(return_url)
  end

  def result
    current_shopping_cart.delete
    session[:cart_id] = nil
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
