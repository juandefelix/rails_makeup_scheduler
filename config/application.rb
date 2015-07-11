require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module RailsMakeupScheduler
  class Application < Rails::Application
    config.assets.initialize_on_precompile = false
    config.autoload_paths << Rails.root.join('lib')

    # CONFIG = YAML.load(File.read(File.expand_path('../school_code.yml', __FILE__)))
    # CONFIG.merge! CONFIG.fetch(Rails.env, {})
    # CONFIG.symbolize_keys!


    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    config.assets.precompile += %w(*.png *.jpg *.jpeg *.gif)
    config.assets.version = '1.0'
    I18n.enforce_available_locales = true

    config.time_zone = 'Central Time (US & Canada)'

    config.before_configuration do
      env_file = File.join(Rails.root, 'config', 'local_env.yml')
      YAML.load(File.open(env_file)).each { |key, value| ENV[key.to_s] = value }
    end unless Rails.env.production?
  end
end
