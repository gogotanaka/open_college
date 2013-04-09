# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
OpenCollege::Application.initialize!

config.action_mailer.delivery_method = :smtp

ActionMailer::Base.smtp_settings = {
  :address        => 'smtp.sendgrid.net',
  :port           => '587',
  :authentication => :plain,
  :user_name      => ENV['app13095918@heroku.com'],
  :password       => ENV['wwf5vkn4'],
  :domain         => 'heroku.com',
  :enable_starttls_auto => true
}