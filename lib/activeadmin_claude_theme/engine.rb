# frozen_string_literal: true

module ActiveadminClaudeTheme
  class Engine < ::Rails::Engine
    isolate_namespace ActiveadminClaudeTheme

    rake_tasks do
      load root.join("lib/tasks/activeadmin_claude_theme_tasks.rake")
    end

    initializer "activeadmin_claude_theme.prepend_views" do
      next unless ActiveadminClaudeTheme::VersionSupport.active_admin_4?

      ActiveSupport.on_load(:action_controller_base) do
        prepend_view_path ActiveadminClaudeTheme::Engine.root.join("app/views")
      end
    end
  end
end
