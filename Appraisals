# frozen_string_literal: true

case RUBY_VERSION

when '2.6.3'
  appraise "ruby-#{RUBY_VERSION}_rails522" do
    gem 'rails', '~> 5.2.2'
  end

  appraise "ruby-#{RUBY_VERSION}_rails6" do
    gem 'rails', '~> 6.0'
  end
else
  raise "Unsupported Ruby version #{RUBY_VERSION}"
end
