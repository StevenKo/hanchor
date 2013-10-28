class PaymentNotificationsController < ApplicationController
  protect_from_forgery :except => [:create]
  
  def create
    Rails.logger.info("PARAMS: #{params.inspect}")
    if (params[:payment_status] == "Completed")
      Order.find(params[:invoice]).update_attribute(:status,"pay_confirm")
    elsif(params[:payment_status] == "Canceled_Reversal" || params[:payment_status] == "Denied")
      Order.destroy(params[:invoice])
    end
    render :nothing => true
  end
end
