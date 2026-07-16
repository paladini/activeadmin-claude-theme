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
end
