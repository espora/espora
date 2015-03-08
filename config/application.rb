require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Espora
  class Application < Rails::Application
    #Espora::Application.config.secret_key_base = '0c98f00121327bbc81fe3a3409e43b6dcbcfcb37015a523a67b906b6dc2a9ac9a7bb008fb1c75769f0d93cacf421f41b6e7c1f72ca1cae1383d47d9c598dd4d9'
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    
    config.i18n.default_locale = :es
  end
end
