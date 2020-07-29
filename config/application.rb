require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module UsaResilienceOpportunityMapApi
  class Application < Rails::Application
    config.middleware.insert_before 0, Rack::Cors,
                                    debug: !Rails.env.production?,
                                    logger: (-> { Rails.logger }) do
      allow do
        origins '*'
        resource '/api/*',
                 headers: %w(Authorization),
                 methods: :any,
                 expose: %w(Authorization),
                 max_age: 600
      end
    end
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0
  end
end
