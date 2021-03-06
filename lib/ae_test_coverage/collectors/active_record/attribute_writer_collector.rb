# frozen_string_literal: true

require 'ae_test_coverage/collectors/active_record/model_collector'
require 'ae_test_coverage/collectors/active_record/attribute_writer_helper'

module AeTestCoverage
  module Collectors
    module ActiveRecord
      class AttributeWriterCollector < ModelCollector

        private

        def set_hook
          ActiveSupport.on_load(:active_record) do
            include AttributeWriterHelper
          end
        end

        def data
          {attribute_written: true}
        end
      end
    end
  end
end
