class PaymentNotificationsController < ApplicationController
  protect_from_forgery :except => [:create]
  
  def create
    Rails.logger.info("PARAMS: #{params.inspect}")
    if (params[:payment_status] == "Completed")
      order = Order.find(params[:invoice])
      order.status = "pay_confirm"
      order.is_show = true
      order.save
    elsif(params[:payment_status] == "Canceled_Reversal" || params[:payment_status] == "Denied")
      Order.destroy(params[:invoice])
    end
    render :nothing => true
  end
end
