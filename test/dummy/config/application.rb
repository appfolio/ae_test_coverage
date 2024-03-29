# frozen_string_literal: true

# Set up gems listed in the Gemfile.
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __dir__)

require 'bundler/setup' if File.exist?(ENV['BUNDLE_GEMFILE'])

require 'active_record/railtie'

Bundler.reset!
Bundler.require(*Rails.groups(assets: %w[development test]))

require "ae_test_coverage"

module AeTestCoverageDummyApp
  class Application < Rails::Application
    config.root = File.expand_path('../', __dir__)
    config.active_record.legacy_connection_handling = false if Rails.version >= '7'

    def name
      "AeTestCoveragedummy"
    end
  end
end

require_relative '../engines/dummy_engine/lib/dummy_engine'
