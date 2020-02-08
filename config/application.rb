require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Dynamic
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    config.assets.enabled = true

    Dir.glob("#{Rails.root}/app/assets/**/").each do |path|
      config.assets.paths << path
    end

    config.time_zone = "Chennai"
    config.active_record.default_timezone = :local
    config.action_mailer.asset_host = 'http://localhost:3000'
    config.active_storage.variant_processor = :vips
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
