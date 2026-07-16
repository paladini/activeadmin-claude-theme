# frozen_string_literal: true

require "fileutils"

namespace :activeadmin_claude_theme do
  desc "Build Active Admin CSS for the dummy app (Tailwind v4)"
  task :build_css do
    dummy = File.expand_path("test/dummy", __dir__)
    env = ENV.to_h.merge("BUNDLE_GEMFILE" => File.expand_path("Gemfile", __dir__))
    system(env, "npm", "run", "build:css", chdir: dummy, exception: true)
  end
end

task "assets:precompile" => "activeadmin_claude_theme:build_css"
