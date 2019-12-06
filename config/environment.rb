# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

# ActionMailer::Base.smtp_settings = {
#   :user_name => 'apikey',
#   :password => 'clef api à mettre ici',
#   :domain => 'yourdomain.com',
#   :address => 'smtp.sendgrid.net',
#   :port => 465,
#   :authentication => :plain,
#   :enable_starttls_auto => true
# }

# ActionMailer::Base.smtp_settings = {
#   :user_name => ENV['SENDGRID_LOGIN'],
#   :password => ENV['SENDGRID_PWD'],
#   :domain => 'monsite.fr',
#   :address => 'smtp.sendgrid.net',
#   :port => 587,
#   :authentication => :plain,
#   :enable_starttls_auto => true
# }

##Pour envoyer des mails avec mon adresse Gmail
# ActionMailer::Base.smtp_settings =   {
#     :address            => 'smtp.gmail.com',
#     :port               => 587,
#     :domain             => 'gmail.com', #you can also use google.com
#     :authentication     => :plain,
#     :user_name          => ENV['GMAIL_LOGIN'],
#     :password           => ENV['GMAIL_PWD']
#   }