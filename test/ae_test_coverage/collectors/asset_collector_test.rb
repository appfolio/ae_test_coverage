# frozen_string_literal: true

require 'test_helper'
require 'ae_test_coverage/collectors/sprockets_asset_collector'

module AeTestCoverage
  module Collectors
    class AssetCollectorTest < ActiveSupport::TestCase
      def test_collect__no_result
        Rails.application.stubs(:assets).returns({})
        assert_empty AeTestCoverage::Collectors::SprocketsAssetCollector.new('abc').collect
      end

      def test_collect__has_result__not_qualified_extension
        dummy_asset = Struct.new(:metadata).new({ dependencies: %w[def.json] })
        Rails.application.stubs(:assets).returns({ 'abc' => dummy_asset })
        assert_empty AeTestCoverage::Collectors::SprocketsAssetCollector.new('abc').collect
      end

      def test_collect__has_result__qualified_extension
        dummy_asset = Struct.new(:metadata).new({ dependencies: %w[def.es6 ghi.css] })
        Rails.application.stubs(:assets).returns({ 'abc' => dummy_asset })
        actual = AeTestCoverage::Collectors::SprocketsAssetCollector.new('abc').collect
        assert_equal %w[def.es6 ghi.css], actual
      end
    end
  end
end
