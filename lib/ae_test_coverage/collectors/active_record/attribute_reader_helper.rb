# frozen_string_literal: true

module AeTestCoverage
  module Collectors
    module ActiveRecord
      module AttributeReaderHelper
        def _read_attribute(attr_name)
          AeTestCoverage.coverage_collectors[AttributeReaderCollector].add_covered_models(self.class)
          super
        end
      end
    end
  end
end
