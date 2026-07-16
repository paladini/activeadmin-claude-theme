# frozen_string_literal: true

module ActiveadminClaudeTheme
  module VersionSupport
    module_function

    def active_admin_version
      spec = Gem.loaded_specs["activeadmin"]
      spec&.version
    end

    def active_admin_4?
      version = active_admin_version
      version && version.segments.first.to_i >= 4
    end

    def active_admin_3?
      version = active_admin_version
      version && version.segments.first.to_i == 3
    end

    def supported?
      active_admin_3? || active_admin_4?
    end
  end
end
