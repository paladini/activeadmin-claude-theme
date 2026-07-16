# frozen_string_literal: true

ENV["RAILS_ENV"] ||= "test"
ENV["BUNDLE_GEMFILE"] ||= File.expand_path("../Gemfile", __dir__)

require "bundler/setup"
require File.expand_path("dummy/config/environment", __dir__)
require "rails/test_help"
require "minitest/autorun"
