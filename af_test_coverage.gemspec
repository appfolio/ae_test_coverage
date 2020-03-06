# frozen_string_literal: true

# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'af_test_coverage/version'

Gem::Specification.new do |spec|
  spec.name          = 'af_test_coverage'
  spec.version       = AfTestCoverage::VERSION
  spec.authors       = ['Appfolio']

  spec.summary       = 'Tools for collecting code coverage from tests'
  spec.description   = 'Tools for collecting code coverage from tests'

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  spec.metadata['allowed_push_host'] = 'https://gemini.atl.appfolio.net'

  spec.files         = Dir['{lib}/**/*']
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'railties', '< 7'
  spec.add_dependency 'activerecord', '< 7'
  spec.add_development_dependency 'bundler', '~> 1.15'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency "simplecov"
end
