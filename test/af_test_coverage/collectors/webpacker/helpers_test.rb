# frozen_string_literal: true

require 'test_helper'

module AfTestCoverage
  module Collectors
    module Webpacker
      class HelpersTest < ActiveSupport::TestCase
        def setup
          AfTestCoverage.stubs(:single_test_coverage_enabled?).returns(true)
          AfTestCoverage.start_coverage
          AfTestCoverage.configure do |config|
            config.webpacker_app_locations = ['test/dummy/app/javascript']
          end

          @mock_collector = mock
          AfTestCoverage.coverage_collectors = {
            WebpackerAppCollector => @mock_collector
          }
        end

        def test_render__javascript_packs_with_chunks_tag__registers_covered_asset
          @mock_collector.expects(:add_covered_globs).never
          view = DummyView.new(::ActionView::LookupContext.new([]), {})
          view.extend(::Webpacker::Helper)
          view.render(inline: '<% javascript_packs_with_chunks_tag "foo" %>')

          @mock_collector.expects(:add_covered_globs).with('test/dummy/app/javascript/foo/src/**.{scss,css,js}', 'test/dummy/app/javascript/foo/package*.json')
          view.extend(AfTestCoverage::Collectors::Webpacker::Helpers)
          view.render(inline: '<% javascript_packs_with_chunks_tag "foo" %>')
        end
      end
    end
  end
end
