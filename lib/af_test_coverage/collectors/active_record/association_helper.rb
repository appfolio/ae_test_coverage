# frozen_string_literal: true

module AfTestCoverage
  module Collectors
    module ActiveRecord
      module AssociationHelper
        def association(name)
          AfTestCoverage.coverage_collectors[AssociationCollector].add_covered_models(self.class)
          super
        end
      end
    end
  end
end
