class UserMailer < ActionMailer::Base
  default from: "data.opencollege@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.signup_confirmation.subject
  #
  def signup_confirmation
    @greeting = "Hi"
    mail to: "yuki.hariguchi@gmail.com", subject: "Sign Up Confirmation"
  end
end
