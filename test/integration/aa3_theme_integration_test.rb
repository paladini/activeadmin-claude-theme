# frozen_string_literal: true

require "test_helper"
require "rack/test"

class Aa3ThemeIntegrationTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Rails.application
  end

  def setup
    skip "AA3-only integration tests" unless ActiveadminClaudeTheme::VersionSupport.active_admin_3?

    AdminUser.find_or_create_by!(email: "admin@example.com") do |user|
      user.password = "password"
      user.password_confirmation = "password"
    end
  end

  def test_login_page_renders
    get "/admin/login"
    assert_equal 200, last_response.status
    assert_includes last_response.body, "active_admin"
  end

  def test_admin_users_index_renders_after_sign_in
    post "/admin/login", admin_user: { email: "admin@example.com", password: "password" }
    follow_redirect! if last_response.redirect?

    get "/admin/admin_users"
    assert_equal 200, last_response.status
    assert_includes last_response.body, "index_table"
    refute_match(/RuntimeError|AssetNotPrecompiled|SassC::SyntaxError/i, last_response.body)
  end

  def test_active_admin_scss_is_present
    scss = Rails.root.join("app/assets/stylesheets/active_admin.scss")
    assert File.exist?(scss)
    assert_includes File.read(scss), "activeadmin_claude_theme/aa3/base"
  end
end
