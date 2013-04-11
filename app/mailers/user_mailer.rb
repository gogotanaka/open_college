class UserMailer < ActionMailer::Base
  default from: "data.opencollege@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.signup_confirmation.subject
  #
  def signup_confirmation(user)
    @user = user
    mail to: user.email, subject: "Sign Up Confirmation"
  end

  def password_reset(user)
    @user = user
    mail :to => user.email, :subject => "Password Reset"
  end

  def confirmation(user)
    @user = user
    mail to: user.university_email, subject: "Confirmation"
  end
  
end