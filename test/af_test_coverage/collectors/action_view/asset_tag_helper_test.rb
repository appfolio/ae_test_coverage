# frozen_string_literal: true

require 'test_helper'

module AfTestCoverage
  module Collectors
    module ActionView
      class AssetTagHelperTest < ActiveSupport::TestCase
        def setup
          AfTestCoverage.stubs(:single_test_coverage_enabled?).returns(true)
          AfTestCoverage.start_coverage

          @mock_collector = mock
          AfTestCoverage.coverage_collectors = {
            AssetTagCollector => @mock_collector
          }
        end

        def test_render__javascript_include_tag__registers_covered_asset
          @mock_collector.expects(:add_covered_assets).never
          view = DummyView.new(::ActionView::LookupContext.new([]), {})
          view.render(inline: '<% javascript_include_tag "foo" %>')

          @mock_collector.expects(:add_covered_assets).with('foo.js')
          view.extend(AfTestCoverage::Collectors::ActionView::AssetTagHelper)
          view.render(inline: '<% javascript_include_tag "foo" %>')
        end

        def test_render__stylesheet_include_tag__registers_covered_asset
          @mock_collector.expects(:add_covered_assets).never
          view = DummyView.new(::ActionView::LookupContext.new([]), {})
          view.render(inline: '<% stylesheet_link_tag "foo" %>')

          @mock_collector.expects(:add_covered_assets).with('foo.css')
          view.extend(AfTestCoverage::Collectors::ActionView::AssetTagHelper)
          view.render(inline: '<% stylesheet_link_tag "foo" %>')
        end
      end
    end
  end
end
