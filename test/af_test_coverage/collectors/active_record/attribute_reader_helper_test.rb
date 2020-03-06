# frozen_string_literal: true

require 'test_helper'

module AfTestCoverage
  module Collectors
    module ActiveRecord
      class AttributeReaderHelperTest < ActiveSupport::TestCase
        def setup
          AfTestCoverage.stubs(:single_test_coverage_enabled?).returns(true)
          AfTestCoverage.stubs(:whole_test_suite_coverage_enabled?).returns(false)
          AfTestCoverage.start_coverage

          @mock_collector = mock
          AfTestCoverage.coverage_collectors = {
            AttributeReaderCollector => @mock_collector
          }
        end

        def test_attribute_reader
          @mock_collector.expects(:add_covered_models).never
          a_dummy = ADummy.new
          a_dummy.attr1

          @mock_collector.expects(:add_covered_models).with(ADummy)
          a_dummy.extend(AfTestCoverage::Collectors::ActiveRecord::AttributeReaderHelper)
          a_dummy.attr1
        end

        def test_attribute_reader__model_not_collected_when_attribute_does_not_exist
          @mock_collector.expects(:add_covered_models).never
          a_dummy = ADummy.new
          a_dummy.extend(AfTestCoverage::Collectors::ActiveRecord::AttributeReaderHelper)
          assert_raises NoMethodError do
            a_dummy.attr2
          end
        end
      end
    end
  end
end
