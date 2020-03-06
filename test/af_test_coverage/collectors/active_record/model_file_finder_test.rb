# frozen_string_literal: true

require 'test_helper'
require 'ae_test_coverage/collectors/active_record/model_file_finder'

module AeTestCoverage
  module Collectors
    module ActiveRecord
      class ModelFileFinderTest < ActiveSupport::TestCase
        class IrregularlyPlacedModel < ::ActiveRecord::Base;
        end

        def test_find_path__root_app_model
          assert_equal Rails.root.join('app', 'models', 'a_dummy.rb').to_s, ModelFileFinder.new.file_path(ADummy)
          assert_equal Rails.root.join('app', 'models', 'b_dummy.rb').to_s, ModelFileFinder.new.file_path(BDummy)
        end

        def test_find_path__root_app_model__under_module_namespace
          assert_equal Rails.root.join('app', 'models', 'some_namespace', 'namespaced_dummy.rb').to_s, ModelFileFinder.new.file_path(SomeNamespace::NamespacedDummy)
        end

        def test_find_path__model_not_found
          assert_equal nil, ModelFileFinder.new.file_path(IrregularlyPlacedModel)
        end

        def test_find_path__engine_model
          assert_equal Rails.root.join('engines', 'dummy_engine', 'app', 'models', 'dummy_engine', 'engine_dummy.rb').to_s, ModelFileFinder.new.file_path(DummyEngine::EngineDummy)
        end
      end
    end
  end
end
