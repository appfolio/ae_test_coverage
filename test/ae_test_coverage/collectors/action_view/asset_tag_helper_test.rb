# frozen_string_literal: true

require 'test_helper'

module AeTestCoverage
  module Collectors
    module ActionView
      class AssetTagHelperTest < ActiveSupport::TestCase
        def setup
          AeTestCoverage.stubs(:single_test_coverage_enabled?).returns(true)
          AeTestCoverage.start_coverage

          @mock_collector = mock
          AeTestCoverage.coverage_collectors = {
            AssetTagCollector => @mock_collector
          }
        end

        def test_render__javascript_include_tag__registers_covered_asset
          @mock_collector.expects(:add_covered_assets).never
          view = DummyView.new(::ActionView::LookupContext.new([]), {}, nil)
          view.render(inline: '<% javascript_include_tag "foo" %>')

          @mock_collector.expects(:add_covered_assets).with('foo.js')
          view.extend(AeTestCoverage::Collectors::ActionView::AssetTagHelper)
          view.render(inline: '<% javascript_include_tag "foo" %>')
        end

        def test_render__stylesheet_include_tag__registers_covered_asset
          @mock_collector.expects(:add_covered_assets).never
          view = DummyView.new(::ActionView::LookupContext.new([]), {}, nil)
          view.render(inline: '<% stylesheet_link_tag "foo" %>')

          @mock_collector.expects(:add_covered_assets).with('foo.css')
          view.extend(AeTestCoverage::Collectors::ActionView::AssetTagHelper)
          view.render(inline: '<% stylesheet_link_tag "foo" %>')
        end
      end
    end
  end
end
