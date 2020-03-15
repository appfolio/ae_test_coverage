# frozen_string_literal: true

require 'ae_test_coverage/collectors/action_view/asset_tag_helper'
require 'ae_test_coverage/collectors/sprockets_asset_collector'

module AeTestCoverage
  module Collectors
    module ActionView
      class AssetTagCollector
        @@action_view_hook_set = false

        def initialize
          unless @@action_view_hook_set
            ActiveSupport.on_load(:action_view) do
              prepend AeTestCoverage::Collectors::ActionView::AssetTagHelper
            end
            @@action_view_hook_set = true
          end
        end

        def on_start
          @covered_assets_collection = Set.new
        end

        def add_covered_assets(*assets)
          @covered_assets_collection&.merge(assets)
        end

        def covered_files
          test_assets = Set.new(
            @covered_assets_collection.flat_map do |asset_path|
              AeTestCoverage::Collectors::SprocketsAssetCollector.new(asset_path).collect
            end
          )
          {}.tap do |coverage_data|
            test_assets.to_a.map do |asset_uri|
              coverage_data[URI.parse(asset_uri).path] = {asset: true}
            end
          end
        end
      end
    end
  end
end
