# frozen_string_literal: true

require "test_helper"
require "capybara/rails"
require "capybara/minitest"

class ThemeIntegrationTest < ActionDispatch::IntegrationTest
  include Capybara::DSL
  include Capybara::Minitest::Assertions

  def setup
    skip "AA4-only integration tests" unless ActiveadminClaudeTheme::VersionSupport.active_admin_4?

    Capybara.app = Rails.application
    Capybara.current_driver = :rack_test
    AdminUser.find_or_create_by!(email: "admin@example.com") do |user|
      user.password = "password"
      user.password_confirmation = "password"
    end
  end

  def teardown
    Capybara.reset_sessions!
  end

  def test_login_page_renders
    visit "/admin/login"
    assert page.has_css?("body")
  end

  def test_admin_users_index_renders
    visit "/admin/login"
    fill_in "admin_user_email", with: "admin@example.com"
    fill_in "admin_user_password", with: "password"
    find("input[type=submit]").click

    visit "/admin/admin_users"
    assert page.has_css?("table")
    refute_match(/RuntimeError|AssetNotPrecompiled/i, page.text)
  end

  def test_built_css_includes_claude_marker
    css_path = Rails.root.join("app/assets/builds/active_admin.css")
    skip "Run npm run build:css in test/dummy first" unless File.exist?(css_path)

    css = File.read(css_path)
    assert_includes css, "cc785c"
  end
end
