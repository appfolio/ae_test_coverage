# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

ENV['RAILS_ENV'] = 'test'
require File.expand_path('../test/dummy/config/environment.rb', __dir__)

require 'create_test_tables'

require "minitest/autorun"

require 'rails/test_help'
require 'mocha/minitest'

Rails.backtrace_cleaner.remove_silencers!

class DummyView < ActionView::Base; end
