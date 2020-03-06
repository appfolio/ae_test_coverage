# frozen_string_literal: true

module AeTestCoverage
  module Collectors
    module ActionView
      module AssetTagHelper
        def javascript_include_tag(*sources)
          AeTestCoverage.coverage_collectors[AssetTagCollector].add_covered_assets(*js_sources(sources))
          super
        end

        def stylesheet_link_tag(*sources)
          AeTestCoverage.coverage_collectors[AssetTagCollector].add_covered_assets(*css_sources(sources))
          super
        end

        private

        def sources_without_options(sources)
          sources.last.is_a?(Hash) ? sources[0...-1] : sources
        end

        def js_sources(sources)
          sources_without_options(sources).map { |source| "#{source}.js" }
        end

        def css_sources(sources)
          sources_without_options(sources).map { |source| "#{source}.css" }
        end
      end
    end
  end
end
