module OrdersHelper
  def format_order_id order_id
    Time.now.strftime("%y%m%d#{order_id}")
  end
end