class PaymentNotificationsController < ApplicationController
  protect_from_forgery :except => [:create]
  
  def create
    Rails.logger.info("PARAMS: #{params.inspect}")
    if (params[:payment_status] == "Completed")
      order = Order.find(params[:invoice])
      order.status = "pay_confirm"
      order.is_show = true
      order.is_payed = true
      order.fill_fake_attribute
      order.save
      UserMailer.order_notification(order.user,order).deliver
    elsif(params[:payment_status] == "Canceled_Reversal" || params[:payment_status] == "Denied")
      order = Order.find(params[:invoice])
      order.is_show = false
      order.save
    end
    render :nothing => true
  end
end
