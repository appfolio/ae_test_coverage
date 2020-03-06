# frozen_string_literal: true

require 'rails/railtie'
require 'active_record'

require 'af_test_coverage/version'
require 'af_test_coverage/test_coverage_methods'

require 'af_test_coverage/collectors/ruby_coverage_collector'
require 'af_test_coverage/collectors/active_record/association_collector'
require 'af_test_coverage/collectors/active_record/attribute_reader_collector'
require 'af_test_coverage/collectors/active_record/attribute_writer_collector'
require 'af_test_coverage/collectors/action_view/asset_tag_collector'
require 'af_test_coverage/collectors/action_view/rendered_template_collector'
require 'af_test_coverage/collectors/webpacker/webpacker_app_collector'

module AfTestCoverage
  class Config
    attr_accessor :enabled_collector_classes
    attr_accessor :webpacker_app_locations
    attr_accessor :file_exclusion_check
    attr_accessor :enable_check
    attr_accessor :coverage_path

    def initialize
      @enabled_collector_classes = [
        AfTestCoverage::Collectors::RubyCoverageCollector,
        AfTestCoverage::Collectors::ActiveRecord::AssociationCollector,
        AfTestCoverage::Collectors::ActiveRecord::AttributeWriterCollector,
        AfTestCoverage::Collectors::ActiveRecord::AttributeReaderCollector,
        AfTestCoverage::Collectors::ActionView::RenderedTemplateCollector,
        AfTestCoverage::Collectors::ActionView::AssetTagCollector,
        AfTestCoverage::Collectors::Webpacker::WebpackerAppCollector
      ]
      @webpacker_app_locations = []
      @file_exclusion_check = Proc.new { |file| false }
      @enable_check = Proc.new { false }
      @coverage_path = './coverage'
    end
  end

  class << self
    attr_accessor :single_test_coverage_enabled, :coverage_collectors

    def configure
      @config ||= Config.new
      yield @config
    end

    def config
      @config ||= Config.new
    end

    def initialize_collectors
      if enabled?
        @coverage_collectors = {}
        config.enabled_collector_classes.each do |coverage_collector_class|
          coverage_collectors[coverage_collector_class] = coverage_collector_class.new
        end
      end
    end

    def start_coverage
      if self.enabled?
        coverage_collectors.values.each do |coverage_collector|
          coverage_collector.on_start
        end
      end
    end

    def exclude_file?(file)
      AfTestCoverage.config.file_exclusion_check.call(file)
    end

    def enabled?
      AfTestCoverage.config.enable_check.call
    end
  end
end
