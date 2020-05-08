require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module InstantApp
  class Application < Rails::Application
    config.load_defaults 6.0

    config.time_zone = "Tokyo"
    config.i18n.default_locale = :ja
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]

    config.generators do |g|
      g.skip_routes true
      g.helper false
      g.assets false
      g.test_framework false
      g.controller_specs false
      g.view_specs false
    end
  end
end
