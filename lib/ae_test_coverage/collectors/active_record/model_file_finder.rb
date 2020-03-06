# frozen_string_literal: true

module AeTestCoverage
  module Collectors
    module ActiveRecord
      class ModelFileFinder
        def file_path(model)
          Rails.application.config.paths['app/models'].each do |model_root|
            path = Rails.root.join(model_root, "#{model.name.underscore}.rb").to_s
            return path if File.exist?(path)
          end
          Rails::Engine.subclasses.each do |engine|
            engine.paths['app/models'].each do |model_root|
              path = engine.root.join(model_root, "#{model.name.underscore}.rb").to_s
              return path if File.exist?(path)
            end
          end

          nil
        end
      end
    end
  end
end
