# frozen_string_literal: true

# Set up gems listed in the Gemfile.
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __dir__)

require 'bundler/setup' if File.exist?(ENV['BUNDLE_GEMFILE'])

# require 'rails/all'
require 'active_record/railtie'

Bundler.reset!
Bundler.require(*Rails.groups(assets: %w[development test]))

require "af_test_coverage"

`mysql -h 127.0.0.1 -uroot -e "DROP DATABASE IF EXISTS aftestcoveragedummy_test; CREATE DATABASE IF NOT EXISTS aftestcoveragedummy_test;"`

module AfTestCoverageDummyApp
  class Application < Rails::Application
    config.root = File.expand_path('../', __dir__)

    def name
      "aftestcoveragedummy"
    end
  end
end

require_relative '../engines/dummy_engine/lib/dummy_engine'
