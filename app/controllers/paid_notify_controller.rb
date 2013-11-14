class PaidNotifyController < ApplicationController
  
  def create
    order = Order.find(params[:order_id])
    bank_str = ""
    params.permit(:bank_name, :bank_account_num, :accunt_name).each{|key,value| bank_str += (key + ":"  + value + "\n")}
    order.bank = bank_str
    order.is_payed = true
    order.fill_fake_attribute
    order.save

    redirect_to account_path
  end


end
