# frozen_string_literal: true

module AfTestCoverage
  module Collectors
    module ActiveRecord
      module AttributeReaderHelper
        def _read_attribute(attr_name)
          AfTestCoverage.coverage_collectors[AttributeReaderCollector].add_covered_models(self.class)
          super
        end
      end
    end
  end
end
