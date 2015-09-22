class PaymentNotificationsController < ApplicationController
  protect_from_forgery :except => [:create,:allpay]
  
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

  def allpay
    Rails.logger.info("PARAMS: #{params.inspect}")
    if (params[:RtnCode] == "1")
      order = Order.find_by(code: params[:MerchantTradeNo])
      if order.is_payed == false
        order.status = "pay_confirm"
        order.is_show = true
        order.is_payed = true
        order.fill_fake_attribute
        order.save
        UserMailer.order_notification(order.user,order).deliver
      end
      render :text => "1|OK"
    elsif(params[:RtnCode] != "1")
      order = Order.find_by(code: params[:MerchantTradeNo])
      order.is_show = false
      order.save
      render :text => "0|Error"
    end
  end
end
