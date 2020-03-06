# frozen_string_literal: true

module AeTestCoverage
  module Collectors
    module ActiveRecord
      module AssociationHelper
        def association(name)
          AeTestCoverage.coverage_collectors[AssociationCollector].add_covered_models(self.class)
          super
        end
      end
    end
  end
end
