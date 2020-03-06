# frozen_string_literal: true

require 'test_helper'

module AfTestCoverage
  module Collectors
    module ActionView
      class RenderedTemplateCollectorTest < ActiveSupport::TestCase
        def test_render__records_rendered_template
          mock_collector = mock
          mock_collector.expects(:add_covered_templates).never
          context = ::ActionView::LookupContext.new(['test/dummy/app/views'])
          view = DummyView.new(context, {})
          AfTestCoverage.expects(:add_covered_templates).never
          view.render(template: 'foo.html.erb')

          expected_path = view.lookup_context.find_template('foo.html.erb').identifier
          mock_collector.expects(:add_covered_templates).with(expected_path)
          AfTestCoverage::Collectors::ActionView::RenderedTemplateCollector.subscribe(mock_collector)
          assert_not_nil AfTestCoverage::Collectors::ActionView::RenderedTemplateCollector.subscriber
          view.render(template: 'foo.html.erb')
        ensure
          AfTestCoverage::Collectors::ActionView::RenderedTemplateCollector.unsubscribe
          assert_nil AfTestCoverage::Collectors::ActionView::RenderedTemplateCollector.subscriber
        end
      end
    end
  end
end
