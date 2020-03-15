# frozen_string_literal: true

module AeTestCoverage
  module Collectors
    class SprocketsAssetCollector
      def initialize(asset_path)
        @asset_path = asset_path
      end

      def collect
        asset = ::Rails.application.assets[@asset_path]
        # It's not clear why an asset would not be found in the cache.  It happens but it seems to happen rarely and repeatably
        # If there is a bug with assets changes not triggering a test to run, look here to see if the asset was not included
        # as a dependency because it was not found in the cache
        
        if asset.nil?
          puts "Skipping asset #{@asset_path} because it was not found in the cache"
          []
        else
          asset.metadata[:dependencies].select { |d| d.ends_with?('.js', '.es6', '.css', '.scss') }
        end
      end
    end
  end
end
 
