# frozen_string_literal: true

require "test_helper"
require "capybara/rails"
require "capybara/minitest"

class ThemeIntegrationTest < ActionDispatch::IntegrationTest
  include Capybara::DSL
  include Capybara::Minitest::Assertions

  def setup
    Capybara.app = Rails.application
    Capybara.current_driver = :rack_test
  end

  def teardown
    Capybara.reset_sessions!
  end

  def test_login_page_renders
    visit "/admin/login"
    assert page.has_css?("body")
  end

  def test_built_css_includes_claude_marker
    css_path = Rails.root.join("app/assets/builds/active_admin.css")
    skip "Run npm run build:css in test/dummy first" unless File.exist?(css_path)

    css = File.read(css_path)
    assert_includes css, "cc785c"
  end
end
