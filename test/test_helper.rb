# frozen_string_literal: true

ENV["RAILS_ENV"] ||= "test"
dummy_path = ENV.fetch("DUMMY_PATH", "dummy")
ENV["BUNDLE_GEMFILE"] ||= if dummy_path == "dummy_aa3"
                            File.expand_path("../gemfiles/activeadmin_3.gemfile", __dir__)
                          else
                            File.expand_path("../Gemfile", __dir__)
                          end

require "bundler/setup"
require File.expand_path("#{dummy_path}/config/environment", __dir__)
require "rails/test_help"
require "minitest/autorun"
