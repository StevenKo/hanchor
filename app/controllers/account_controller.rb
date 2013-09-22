class AccountController < ApplicationController
  before_action :require_user
  before_action :get_cart_items

  def index
  end

  def info
  end

  def orders
  end

end
