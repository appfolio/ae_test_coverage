# frozen_string_literal: true

module AeTestCoverage
  module Collectors
    module Webpacker
      module Helpers
        def javascript_packs_with_chunks_tag(*names, **options)
          raise(StandardError, 'AeTestCoverage.config.webpacker_app_locations must be set to collect webpacker app coverage') if AeTestCoverage.config.webpacker_app_locations.blank?

          globs = names.flat_map do |name|
            app_home = javascript_app_home(name)
            raise(StandardError, "Unable to locate source location for javascript app #{name}") unless Dir.exist?(app_home)

            [
              File.join(app_home, 'src', '**.{scss,css,js}'),
              File.join(app_home, 'package*.json')
            ]
          end
          AeTestCoverage.coverage_collectors[WebpackerAppCollector].add_covered_globs(*globs)
          super
        end

        def javascript_app_home(name)
          AeTestCoverage.config.webpacker_app_locations.map do |potential_app_root|
            File.join(potential_app_root, name)
          end.detect do |potential_app_home|
            Dir.exist?(potential_app_home)
          end
        end
      end
    end
  end
end
