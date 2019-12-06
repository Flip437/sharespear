require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Sharespeare
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    config.action_mailer.raise_delivery_errors = false
    config.action_mailer.perform_deliveries = true

    config.action_mailer.smtp_settings = {
      :address => "in.mailjet.com",
      :enable_starttls_auto => true,
      :port => 587,
      :authentication => 'plain',
      :user_name => ENV['MAILJET_LOGIN'],
      :password =>  ENV['MAILJET_PWD']

    }
  end






end
