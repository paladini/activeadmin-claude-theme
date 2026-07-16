require_relative "boot"

require "rails"
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
require "rails/test_unit/railtie"

Bundler.require(*Rails.groups)
require "activeadmin_claude_theme"

module DummyAa3
  class Application < Rails::Application
    config.root = File.expand_path("..", __dir__)
    config.load_defaults 7.2
    config.autoload_lib(ignore: %w[assets tasks])
    config.generators.system_tests = nil
  end
end
