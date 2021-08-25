# frozen_string_literal: true

case RUBY_VERSION

when '2.6.3'
  appraise "ruby-#{RUBY_VERSION}_rails522" do
    source 'https://rubygems.org' do
      gem 'rails', '~> 5.2.2'
    end
  end

  appraise "ruby-#{RUBY_VERSION}_rails6" do
    source 'https://rubygems.org' do
      gem 'rails', '~> 6.0'
    end
  end
else
  raise "Unsupported Ruby version #{RUBY_VERSION}"
end
