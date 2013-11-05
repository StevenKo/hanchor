class UserMailer < ActionMailer::Base
  default from: 'Hanchor@hanchor.com'

  def register_email(user)
    @user = user
    mail(to: @user.email, subject: "Thanks for registering on HANCHOR")
  end

  def reset_password_email(user)
    @user = user
    mail(to: @user.email, subject: t('mail.reset_password'))
  end

  def order_notification(user,order)
    @user = user
    @order = order
    mail(to: @user.email, subject: t(:order, :scope => "mail", :order_code => order.code))
  end
end