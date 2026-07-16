# frozen_string_literal: true

require "rails/generators/base"

module ActiveadminClaudeTheme
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc "Install the Claude theme into an Active Admin 4 app."

      AA_TW_SRC = "app/assets/tailwind/active_admin.css"
      AA_TW_SRC_LEGACY = "app/assets/stylesheets/active_admin.css"
      TW_CONF = "tailwind-active_admin.config.js"
      PACKAGE_JSON = "package.json"
      FONTS_IMPORT = <<~CSS
        @import url("https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=JetBrains+Mono:wght@400;500&family=Source+Serif+4:opsz,wght@8..60,400;8..60,600&display=swap");
      CSS

      def vendor_theme_css
        css = ActiveadminClaudeTheme::Engine.root.join("app/assets/stylesheets/activeadmin_claude_theme.css").read
        create_file "app/assets/tailwind/activeadmin_claude_theme.css", css
      end

      def relocate_active_admin_source
        return if File.exist?(AA_TW_SRC)

        if File.exist?(AA_TW_SRC_LEGACY)
          create_file AA_TW_SRC, File.read(AA_TW_SRC_LEGACY)
          remove_file AA_TW_SRC_LEGACY
          say "Moved Active Admin Tailwind source to #{AA_TW_SRC} (keeps Propshaft from serving uncompiled CSS).", :green
        else
          say "Skipped relocate: run `rails g active_admin:assets` first.", :yellow
        end
      end

      def import_into_build
        return unless File.exist?(AA_TW_SRC)

        import_line = %(@import "./activeadmin_claude_theme.css";\n)
        return if File.read(AA_TW_SRC).include?("activeadmin_claude_theme.css")

        inject_into_file AA_TW_SRC, import_line, after: /@import "tailwindcss";\n/

        return if File.read(AA_TW_SRC).include?("fonts.googleapis.com")

        inject_into_file AA_TW_SRC, FONTS_IMPORT, before: /@import "tailwindcss";\n/
      end

      def configure_build_script
        return unless File.exist?(PACKAGE_JSON)

        package = File.read(PACKAGE_JSON)
        return if package.include?("app/assets/tailwind/active_admin.css")

        gsub_file PACKAGE_JSON,
                  "./app/assets/stylesheets/active_admin.css",
                  "./app/assets/tailwind/active_admin.css"
      end

      def add_view_content_source
        return unless File.exist?(TW_CONF)
        return if File.read(TW_CONF).include?("activeadmin-claude-theme")

        snippet = <<~JS
              `${execSync('bundle show activeadmin-claude-theme', { encoding: 'utf-8' }).trim().split(/\\r?\\n/).pop()}/app/views/**/*.{erb,html,arb,rb}`,
        JS

        inject_into_file TW_CONF, snippet, after: "content: [\n"
      end

      def patch_tailwind_config_bundle_gemfile
        return unless File.exist?(TW_CONF)
        return if File.read(TW_CONF).include?("BUNDLE_GEMFILE")

        inject_into_file TW_CONF,
                         "process.env.BUNDLE_GEMFILE ||= require('path').resolve(__dirname, 'Gemfile');\n\n",
                         before: "const activeAdminPath"
      rescue StandardError
        inject_into_file TW_CONF,
                         "process.env.BUNDLE_GEMFILE ||= require('path').resolve(__dirname, 'Gemfile');\n\n",
                         after: "import activeAdminPlugin from '@activeadmin/activeadmin/plugin';\n\n"
      end

      def done
        say "Claude theme installed.", :green
        say "Rebuild CSS: npm run build:css", :green
        say "Restart your Rails server after rebuilding.", :green
      end
    end
  end
end
