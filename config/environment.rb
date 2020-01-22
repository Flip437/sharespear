# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

# ActionMailer::Base.smtp_settings = {
#     :user_name => ENV['SENDGRID_LOGIN'],
#     :password => ENV['SENDGRID_API_KEY'],
#     :domain => 'sharespeare.fr',
#     :address => 'smtp.sendgrid.net',
#     :port => 465,
#     :authentication => :plain,
#     :enable_starttls_auto => true,
#     :tls => true
# }

# SMTP settings for gmail
ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :user_name            => ENV['GMAIL_LOGIN'],
  :password             => ENV['GMAIL_PASSWORD'],
  :authentication       => "plain",
  :enable_starttls_auto => true
}