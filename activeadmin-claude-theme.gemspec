require_relative "lib/activeadmin_claude_theme/version"

Gem::Specification.new do |spec|
  spec.name        = "activeadmin-claude-theme"
  spec.version     = ActiveadminClaudeTheme::VERSION
  spec.authors     = [ "Fernando Paladini" ]
  spec.email       = [ "fpaladini@gmail.com" ]
  spec.homepage    = "https://github.com/paladini/activeadmin-claude-theme"
  spec.summary     = "Claude-inspired Active Admin theme for Rails — AA3 (Sass) and AA4 (Tailwind v4)."
  spec.description = "Open-source Rails admin theme for Active Admin 3 and 4. Warm cream canvas, coral accents, editorial typography, and optional dark mode on AA4. Install with `rails generate activeadmin_claude_theme:install`. Community theme — not affiliated with Anthropic."
  spec.license     = "MIT"
  spec.required_ruby_version = ">= 3.2.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["documentation_uri"] = "#{spec.homepage}/blob/main/README.md"
  spec.metadata["bug_reports_uri"] = "#{spec.homepage}/issues"
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/main/CHANGELOG.md"
  spec.metadata["rubygems_mfa_required"] = "true"

  spec.files = Dir.chdir(__dir__) do
    Dir[
      "{app,config,lib}/**/*",
      "DESIGN.md",
      "LICENSE",
      "MIT-LICENSE",
      "README.md",
      "CONTRIBUTING.md",
      "CODE_OF_CONDUCT.md",
      "CHANGELOG.md",
      "llms.txt",
      "docs/*.md"
    ]
  end

  spec.require_paths = [ "lib" ]

  spec.add_dependency "rails", ">= 7.2"
  spec.add_dependency "activeadmin", ">= 3.2.0", "< 5"
end
