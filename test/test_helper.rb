ENV['RAILS_ENV'] ||= 'test'


unless ENV['CI']
  require 'simplecov'
  SimpleCov.start 'rails' do
    add_filter '/test/'
    add_filter '/config/'
    add_filter '/lib/middleware/'
    add_filter '/lib/sunspot/'
    add_filter '/vendor/'

    add_group 'Controllers', 'app/controllers'
    add_group 'Models', 'app/models'
    add_group 'Helpers', 'app/helpers'
    add_group 'Mailers', 'app/mailers'
    add_group 'Views', 'app/views'
  end

  all_files = Dir['**/*.rb']
  base_result = {}
  all_files.each do |file|
    absolute = File::expand_path(file)
    lines = File.readlines(absolute, :encoding => 'UTF-8')
    base_result[absolute] = lines.map do |l|
      l.strip!
      l.empty? || l =~ /^else$/ || l =~ /^end$/ || l[0] == '#' ? nil : 0
    end
  end

  SimpleCov.at_exit do
    merged = SimpleCov::Result.new(Coverage.result).original_result.merge_resultset(base_result)
    result = SimpleCov::Result.new(merged)
    result.format!
  end
end

require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end
