# frozen_string_literal: true

require "test_helper"

class ActiveadminClaudeThemeTest < Minitest::Test
  def test_version_is_present
    refute_empty ActiveadminClaudeTheme::VERSION
  end

  def test_engine_is_rails_engine
    assert ActiveadminClaudeTheme::Engine < Rails::Engine
  end

  def test_theme_css_contains_claude_tokens
    css = ActiveadminClaudeTheme::Engine.root.join("app/assets/stylesheets/activeadmin_claude_theme.css").read
    assert_includes css, "--claude-primary: #cc785c"
    assert_includes css, "@theme"
  end

  def test_version_support_detects_active_admin_major
    if ActiveadminClaudeTheme::VersionSupport.active_admin_4?
      assert ActiveadminClaudeTheme::VersionSupport.active_admin_4?
      refute ActiveadminClaudeTheme::VersionSupport.active_admin_3?
    elsif ActiveadminClaudeTheme::VersionSupport.active_admin_3?
      assert ActiveadminClaudeTheme::VersionSupport.active_admin_3?
      refute ActiveadminClaudeTheme::VersionSupport.active_admin_4?
    else
      flunk "Expected Active Admin 3 or 4 in test environment"
    end
  end

  def test_aa3_scss_contains_claude_variables
    variables = ActiveadminClaudeTheme::Engine.root.join(
      "app/assets/stylesheets/activeadmin_claude_theme/aa3/_variables.scss"
    ).read
    assert_includes variables, "$primary-color: $claude-primary"
    assert_includes variables, "$claude-primary: #cc785c"
  end

  def test_aa3_base_entry_imports_active_admin
    base = ActiveadminClaudeTheme::Engine.root.join(
      "app/assets/stylesheets/activeadmin_claude_theme/aa3/base.scss"
    ).read
    assert_includes base, '@import "active_admin/base"'
    assert_includes base, "activeadmin_claude_theme/aa3/overrides"
  end

  def test_aa4_view_overrides_not_prepended_on_aa3
    skip "AA4-only assertion" unless ActiveadminClaudeTheme::VersionSupport.active_admin_3?

    view_paths = ActionController::Base.view_paths.map(&:to_s)
    refute view_paths.any? { |path| path.include?("activeadmin_claude_theme") && path.include?("app/views") }
  end
end
