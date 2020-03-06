# frozen_string_literal: true

require 'af_test_coverage/collectors/webpacker/helpers'

module AfTestCoverage
  module Collectors
    module Webpacker
      class WebpackerAppCollector
        @@hook_set = false

        def initialize
          unless @@hook_set
            ActiveSupport.on_load(:action_view) do
              prepend AfTestCoverage::Collectors::Webpacker::Helpers
            end
          end
          @@hook_set = true
        end

        def on_start
          @covered_globs = Set.new
        end

        def add_covered_globs(*globs)
          @covered_globs&.merge(globs)
        end

        def covered_files
          {}.tap do |coverage_data|
            @covered_globs.each do |glob_pattern|
              coverage_data[glob_pattern] = { glob: true }
            end
          end
        end
      end
    end
  end
end
