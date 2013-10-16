class UserMailer < ActionMailer::Base
  default from: 'Hanchor@hanchor.com'

  def register_email(user)
    @user = user
    mail(to: @user.email, subject: t('mail.register_success'))
  end

  def reset_password_email(user)
    @user = user
    mail(to: @user.email, subject: t('mail.reset_password'))
  end
end