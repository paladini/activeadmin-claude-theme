# frozen_string_literal: true

require "rails/generators/base"

module ActiveadminClaudeTheme
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc "Install the Claude theme into an Active Admin 4 app."

      AA_TW_SRC = "app/assets/tailwind/active_admin.css"
      AA_TW_SRC_LEGACY = "app/assets/stylesheets/active_admin.css"
      TW_CONF = "tailwind-active_admin.config.js"

      def vendor_theme_css
        css = ActiveadminClaudeTheme::Engine.root.join("app/assets/stylesheets/activeadmin_claude_theme.css").read
        create_file "app/assets/tailwind/activeadmin_claude_theme.css", css
      end

      def import_into_build
        target = if File.exist?(AA_TW_SRC)
          AA_TW_SRC
        elsif File.exist?(AA_TW_SRC_LEGACY)
          AA_TW_SRC_LEGACY
        end

        unless target
          say "Skipped @import: Active Admin tailwind entry not found — run `rails g active_admin:assets` first.", :yellow
          return
        end

        import_line = %(@import "../tailwind/activeadmin_claude_theme.css";\n)
        return if File.read(target).include?("activeadmin_claude_theme.css")

        inject_into_file target, import_line, after: /@import "tailwindcss";\n/
      end

      def add_view_content_source
        return unless File.exist?(TW_CONF)
        return if File.read(TW_CONF).include?("activeadmin_claude_theme")

        snippet = <<~JS
              `${execSync('bundle show activeadmin-claude-theme', { encoding: 'utf-8' }).trim().split(/\\r?\\n/).pop()}/app/views/**/*.{erb,html,arb,rb}`,
        JS

        inject_into_file TW_CONF, snippet, after: "content: [\n"
      end

      def done
        say "Claude theme installed.", :green
        say "1. Add Google Fonts to active_admin.css (see README)", :green
        say "2. Ensure tailwind-active_admin.config.js sets BUNDLE_GEMFILE (see dummy example)", :green
        say "3. Rebuild CSS: npm run build:css", :green
      end
    end
  end
end
