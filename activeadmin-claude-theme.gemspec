require_relative "lib/activeadmin_claude_theme/version"

Gem::Specification.new do |spec|
  spec.name        = "activeadmin-claude-theme"
  spec.version     = ActiveadminClaudeTheme::VERSION
  spec.authors     = ["Fernando Paladini"]
  spec.email       = ["fpaladini@gmail.com"]
  spec.homepage    = "https://github.com/paladini/activeadmin-claude-theme"
  spec.summary     = "A warm, editorial Claude-inspired theme for Active Admin 4."
  spec.description = "Community theme gem for Active Admin 4 (Tailwind v4) inspired by Claude/Anthropic aesthetics — warm canvas, coral accents, dark mode, and mobile-ready admin chrome."
  spec.license     = "MIT"
  spec.required_ruby_version = ">= 3.2.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["rubygems_mfa_required"] = "true"

  spec.files = Dir.chdir(__dir__) do
    Dir[
      "{app,config,lib}/**/*",
      "DESIGN.md",
      "LICENSE",
      "MIT-LICENSE",
      "README.md",
      "CONTRIBUTING.md",
      "CODE_OF_CONDUCT.md"
    ]
  end

  spec.require_paths = ["lib"]

  spec.add_dependency "rails", ">= 7.2"
  spec.add_dependency "activeadmin", ">= 4.0.0.beta22", "< 5"
end
