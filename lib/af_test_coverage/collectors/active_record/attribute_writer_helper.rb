# frozen_string_literal: true

module AeTestCoverage
  module Collectors
    module ActiveRecord
      module AttributeWriterHelper
        def _write_attribute(attr_name, value)
          AeTestCoverage.coverage_collectors[AttributeWriterCollector].add_covered_models(self.class)
          super
        end
      end
    end
  end
end
