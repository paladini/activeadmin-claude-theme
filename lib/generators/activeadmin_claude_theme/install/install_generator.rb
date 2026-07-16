# frozen_string_literal: true

require "rails/generators/base"
require "activeadmin_claude_theme/version_support"

module ActiveadminClaudeTheme
  module Generators
    class InstallGenerator < Rails::Generators::Base
      desc "Install the Claude theme into an Active Admin 3 or 4 app."

      AA_TW_SRC = "app/assets/tailwind/active_admin.css"
      AA_TW_SRC_LEGACY = "app/assets/stylesheets/active_admin.css"
      AA3_SCSS = "app/assets/stylesheets/active_admin.scss"
      TW_CONF = "tailwind-active_admin.config.js"
      PACKAGE_JSON = "package.json"
      FONTS_IMPORT = <<~CSS
        @import url("https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=JetBrains+Mono:wght@400;500&family=Source+Serif+4:opsz,wght@8..60,400;8..60,600&display=swap");
      CSS
      AA3_ENTRY = '@import "activeadmin_claude_theme/aa3/base";'

      def install
        if ActiveadminClaudeTheme::VersionSupport.active_admin_4?
          install_aa4
        elsif ActiveadminClaudeTheme::VersionSupport.active_admin_3?
          install_aa3
        else
          raise Thor::Error, "Unsupported Active Admin version. Requires Active Admin 3.2+ or 4.0+."
        end
      end

      private

      def install_aa4
        vendor_theme_css
        relocate_active_admin_source
        import_into_build
        configure_build_script
        add_view_content_source
        patch_tailwind_config_bundle_gemfile
        say "Claude theme installed for Active Admin 4.", :green
        say "Rebuild CSS: npm run build:css", :green
        say "Restart your Rails server after rebuilding.", :green
      end

      def install_aa3
        configure_active_admin_scss
        ensure_manifest_includes_active_admin
        say "Claude theme installed for Active Admin 3.", :green
        say "Ensure Sprockets compiles SCSS (sassc-rails or dartsass-rails).", :green
        say "Restart your Rails server.", :green
      end

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

      def configure_active_admin_scss
        if File.exist?(AA3_SCSS)
          patch_existing_aa3_scss
        else
          create_file AA3_SCSS, <<~SCSS
            #{AA3_ENTRY}
          SCSS
          say "Created #{AA3_SCSS} with Claude theme entry.", :green
        end
      end

      def patch_existing_aa3_scss
        content = File.read(AA3_SCSS)
        return if content.include?("activeadmin_claude_theme/aa3/base")

        if content.match?(/@import\s+"active_admin\/base"/)
          gsub_file AA3_SCSS, /@import\s+"active_admin\/mixins";\s*\n?/, ""
          gsub_file AA3_SCSS, /@import\s+"active_admin\/base";\s*\n?/, "#{AA3_ENTRY}\n"
          say "Replaced active_admin/base import with Claude AA3 theme.", :green
        elsif content.match?(%r{//=\s*require\s+active_admin/base})
          gsub_file AA3_SCSS, %r{//=\s*require\s+active_admin/base\s*\n?}, "#{AA3_ENTRY}\n"
          say "Replaced Sprockets require with Claude AA3 theme import.", :green
        else
          inject_into_file AA3_SCSS, "#{AA3_ENTRY}\n", before: /\z/
          say "Appended Claude AA3 theme import to #{AA3_SCSS}.", :yellow
        end
      end

      def ensure_manifest_includes_active_admin
        manifest = "app/assets/config/manifest.js"
        return unless File.exist?(manifest)
        return if File.read(manifest).include?("active_admin")

        append_to_file manifest, <<~JS

          //= link active_admin.css
        JS
        say "Added active_admin.css to #{manifest}.", :green
      end
    end
  end
end
