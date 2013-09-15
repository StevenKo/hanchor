class OrdersController < ApplicationController
  before_action :get_cart_items

  def create
    return_url = result_orders_url
    redirect_to current_shopping_cart.paypal_url(return_url)
  end

  def result
    binding.pry
  end

end
