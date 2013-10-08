module OrdersHelper
  def format_order_id order
    order.created_at.strftime("%y%m%d#{order.id}")
  end
end