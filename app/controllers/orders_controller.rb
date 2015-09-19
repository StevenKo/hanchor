# encoding: utf-8
class OrdersController < ApplicationController
  before_action :get_cart_items

  def create
    @order = Order.new(order_params)
    unless get_good_from_store(@order)
      @order.store_code = 0
      @order.store_name = "Fake Store"
    end
    @order.user_id = current_user.id
    @cart_items.each do |cart_item|
      order_item = OrderItem.new(product_id: cart_item.product_id, quantity: cart_item.quantity, price: cart_item.price, product_size_id: cart_item.product_size_id, product_color_id: cart_item.product_color_id)
      @order.order_items << order_item
    end
    @order.total = @order.sum_item_price + ShippingCost.find(params[:order][:shipping_cost_id]).cost if params[:order][:shipping_cost_id].present?
    @order.memo = params[:memo]
    @order.status = "order_confirm"
    @order.shipping_store = "#{params[:order][:store_code]},#{params[:order][:store_name]}" if(params[:order][:store_code] && params[:order][:store_name])

    if @order.dose_not_have_product_in_stock
      flash[:error] = @order.quantity_error_mesage(@country_id)
      redirect_to :back
    else
      if @order.save
        @order.update_attribute(:code, @order.created_at.utc.strftime("%y%m%d")+ (Order.where("created_at > ?", @order.created_at.utc.to_date).size).to_s.rjust(3, '0'))
        @order.deduct_quanitity
        if(@order.payment == "PayPal" && ["zh-TW","zh"].include?( params[:locale] ))
          product_ids = @order.order_items.map(&:product_id)
          products = Product.includes(:thumb,:product_category).joins(:product_infos).where("product_infos.country_id = #{@country_id} and products.id in (#{product_ids.join(",")})").cart_info
          product_infos = {}
          products.each {|product| product_infos[product.id] = product}
          @order_products = []
          product_ids.each { |id| @order_products << product_infos[id] }

          render :pay_with_credit_card
        elsif(@order.payment == "PayPal")
          return_url = result_orders_url(order: @order)
          redirect_to current_shopping_cart.paypal_url(return_url,params[:locale],payment_notifications_url,@order.id,ShippingCost.find(params[:order][:shipping_cost_id]))
        else
          UserMailer.order_notification(current_user,@order).deliver
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

  def pay_with_credit_card
  end

  def result
    current_shopping_cart.delete if current_shopping_cart
    session[:cart_id] = nil
    @order = Order.find_by(id: params[:order], user_id: current_user.id)

    redirect_to root_path if @order.nil?
  end

  private

  def get_good_from_store(order)
    order.shipping_cost_id == 3
  end

  def order_params
    params.require(:order).permit(:shipping_name, :phone, :zip_code, :country, :city, :state, :shipping_address, :shipping_cost_id, :payment, :store_code, :store_name)
  end

end
