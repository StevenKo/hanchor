class UserMailer < ActionMailer::Base
  default from: 'chunyuko85@gmail.com'

  def register_email(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to Myflix Site')
  end

  def reset_password_email(user)
    @user = user
    mail(to: @user.email, subject: 'Reset Password')
  end
end