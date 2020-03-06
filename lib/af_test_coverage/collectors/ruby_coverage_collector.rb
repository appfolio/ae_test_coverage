# frozen_string_literal: true

module AfTestCoverage
  module Collectors
    class RubyCoverageCollector
      @@initialized = false

      def initialize
        unless @@initialized
          require 'coverage'
          Coverage.start(oneshot_lines: true, methods: true)
          @@initialized = true
        end
      end

      def on_start
        Coverage.result(clear: true)
      end

      def covered_files
        coverage = Coverage.result(clear: true)
        {}.tap do |coverage_data|
          coverage.each do |file, data|
            next if AfTestCoverage.exclude_file?(file)

            called_methods = data[:methods].select { |_, call_count| call_count > 0 }
            oneshot_lines = reject_oneshot_lines_from_methods(called_methods, data[:oneshot_lines])
            coverage_data[file] = {methods: called_methods, oneshot_lines: oneshot_lines} unless called_methods.empty? && oneshot_lines.empty?
          end
        end
      end

      private

      def reject_oneshot_lines_from_methods(methods, oneshot_lines)
        return [] if oneshot_lines.blank?

        ranges_covered_by_called_methods = methods.keys.map { |method_data| method_data[2]..method_data[4] }
        oneshot_lines.reject { |line| ranges_covered_by_called_methods.any? { |range| range.include?(line) } }
      end
    end
  end
end
