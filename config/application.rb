require_relative 'boot'

require 'rails/all'
require 'devise'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Whistlblowr
  class Application < Rails::Application
    config.exceptions_app = self.routes
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
/home/ben/.rbenv/versions/2.3.1/lib/ruby/gems/2.3.0/gems/actionpack-5.0.0.1/lib/action_dispatch/middleware/templates/rescues/_trace.html.erb
