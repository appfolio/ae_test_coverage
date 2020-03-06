# frozen_string_literal: true

require 'ae_test_coverage/collectors/active_record/model_file_finder'

module AeTestCoverage
  module Collectors
    module ActiveRecord
      class ModelCollector

        def initialize
          set_hook
        end

        def on_start
          @covered_model_collection = Set.new
        end

        def add_covered_models(*models)
          @covered_model_collection&.merge(models)
        end

        def covered_files
          {}.tap do |coverage_data|
            @covered_model_collection.each do |model|
              file = ModelFileFinder.new.file_path(model)
              coverage_data[file] = data
            end
          end
        end

        private

        def set_hook
          raise 'Not Implemented'
          ActiveSupport.on_load(:active_record) do
            raise "helper_module is not defined" unless @@helper_module.present?
            include @@helper_module
          end
        end

        def data
          nil
        end
      end
    end
  end
end
