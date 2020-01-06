require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
# require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Myapp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # auto load 
    config.autoload_paths += %W(#{config.root}/lib/jwt)

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true


    # Mail delivery
    config.action_mailer.default_url_options = {:host => ENV["SES_HOST"]}

    config.action_mailer.smtp_settings = {
        :address => ENV["SES_ADDRESS"],
        :port => 587,
        :user_name => ENV["SES_SMTP_USERNAME"], #Your SMTP user
        :password => ENV["SES_SMTP_PASSWORD"], #Your SMTP password
        :authentication => :login,
        :enable_starttls_auto => true
    }


  end
end
