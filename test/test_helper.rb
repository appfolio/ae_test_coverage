# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

ENV['RAILS_ENV'] = 'test'
require File.expand_path('../test/dummy/config/environment.rb', __dir__)

ActiveRecord::Tasks::DatabaseTasks.env = 'test'
ActiveRecord::Tasks::DatabaseTasks.drop_current
ActiveRecord::Tasks::DatabaseTasks.create_current

require 'create_test_tables'

require "minitest/autorun"

require 'rails/test_help'
require 'mocha/minitest'

Rails.backtrace_cleaner.remove_silencers!

class DummyView < ActionView::Base
 def compiled_method_container
   self.class
 end
end
