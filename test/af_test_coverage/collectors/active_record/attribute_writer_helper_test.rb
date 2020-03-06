# frozen_string_literal: true

require 'test_helper'

module AfTestCoverage
  module Collectors
    module ActiveRecord
      class AttributeWriterHelperTest < ActiveSupport::TestCase
        def setup
          AfTestCoverage.stubs(:single_test_coverage_enabled?).returns(true)
          AfTestCoverage.stubs(:whole_test_suite_coverage_enabled?).returns(false)
          AfTestCoverage.start_coverage
        end

        def test_attribute_reader
          @mock_collector = mock
          AfTestCoverage.coverage_collectors = {
            AttributeWriterCollector => @mock_collector
          }

          @mock_collector.expects(:add_covered_models).never
          a_dummy = ADummy.new
          a_dummy.attr1 = 'dumb'

          @mock_collector.expects(:add_covered_models).with(ADummy)
          a_dummy.extend(AfTestCoverage::Collectors::ActiveRecord::AttributeWriterHelper)
          a_dummy.attr1 = 'and dumber'
        end
      end
    end
  end
end
