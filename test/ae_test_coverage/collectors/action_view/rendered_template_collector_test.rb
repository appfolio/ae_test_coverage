# frozen_string_literal: true

require 'test_helper'

module AeTestCoverage
  module Collectors
    module ActionView
      class RenderedTemplateCollectorTest < ActiveSupport::TestCase
        def test_render__records_rendered_template
          mock_collector = mock
          mock_collector.expects(:add_covered_templates).never
          context = ::ActionView::LookupContext.new(['test/dummy/app/views'])
          view = DummyView.new(context, {}, nil)
          AeTestCoverage.expects(:add_covered_templates).never
          view.render(template: 'foo')

          expected_path = view.lookup_context.find_template('foo').identifier
          mock_collector.expects(:add_covered_templates).with(expected_path)
          AeTestCoverage::Collectors::ActionView::RenderedTemplateCollector.subscribe(mock_collector)
          assert_not_nil AeTestCoverage::Collectors::ActionView::RenderedTemplateCollector.subscriber
          view.render(template: 'foo')
        ensure
          AeTestCoverage::Collectors::ActionView::RenderedTemplateCollector.unsubscribe
          assert_nil AeTestCoverage::Collectors::ActionView::RenderedTemplateCollector.subscriber
        end
      end
    end
  end
end
