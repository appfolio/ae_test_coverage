# frozen_string_literal: true

require_relative 'lib/ae_test_coverage/version'

Gem::Specification.new do |spec|
  spec.name                  = 'ae_test_coverage'
  spec.version               = AeTestCoverage::VERSION
  spec.platform              = Gem::Platform::RUBY
  spec.author                = 'AppFolio'
  spec.email                 = 'opensource@appfolio.com'
  spec.description           = 'Tools for collecting code coverage from tests.'
  spec.summary               = spec.description
  spec.homepage              = 'https://github.com/appfolio/ae_test_coverage'
  spec.license               = 'MIT'
  spec.files                 = Dir['**/*'].select { |f| f[%r{^(lib/|LICENSE.txt|.*gemspec)}] }
  spec.require_paths         = ['lib']
  spec.required_ruby_version = Gem::Requirement.new('>= 2.6.3')

  spec.metadata['allowed_push_host'] = 'https://rubygems.org'
end
