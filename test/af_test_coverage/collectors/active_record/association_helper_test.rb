# frozen_string_literal: true

require 'test_helper'

module AeTestCoverage
  module Collectors
    module ActiveRecord
      class AssociationHelperTest < ActiveSupport::TestCase
        def setup
          AeTestCoverage.stubs(:single_test_coverage_enabled?).returns(true)
          AeTestCoverage.stubs(:whole_test_suite_coverage_enabled?).returns(false)
          AeTestCoverage.start_coverage

          @mock_collector = mock
          AeTestCoverage.coverage_collectors = {
            AssociationCollector => @mock_collector
          }
        end

        def test_reference_adds_model_to_covered_models__belongs_to
          @mock_collector.expects(:add_covered_models).never
          model_with_association = ModelWithAssociation.new
          model_with_association.a_dummy

          @mock_collector.expects(:add_covered_models).with(ModelWithAssociation)
          model_with_association.extend(AeTestCoverage::Collectors::ActiveRecord::AssociationHelper)
          model_with_association.a_dummy
        end

        def test_reference_adds_model_to_covered_models__has_one
          @mock_collector.expects(:add_covered_models).never
          a_dummy = ADummy.new
          a_dummy.model_with_association

          @mock_collector.expects(:add_covered_models).with(ADummy)
          a_dummy.extend(AeTestCoverage::Collectors::ActiveRecord::AssociationHelper)
          a_dummy.model_with_association
        end

        def test_reference_adds_model_to_covered_models__has_many
          @mock_collector.expects(:add_covered_models).never
          b_dummy = BDummy.new
          b_dummy.model_with_associations

          @mock_collector.expects(:add_covered_models).with(BDummy)
          b_dummy.extend(AeTestCoverage::Collectors::ActiveRecord::AssociationHelper)
          b_dummy.model_with_associations
        end

        def test_reference_adds_model_to_covered_models__has_and_belongs_to_many
          @mock_collector.expects(:add_covered_models).never
          model_with_association = ModelWithAssociation.new
          model_with_association.c_dummies

          @mock_collector.expects(:add_covered_models).with(ModelWithAssociation)
          model_with_association.extend(AeTestCoverage::Collectors::ActiveRecord::AssociationHelper)
          model_with_association.c_dummies
        end
      end
    end
  end
end
