require 'simplecov'
SimpleCov.start do 

	coverage_dir 'tmp/coverage/unit'

	add_filter 'spec/'
	add_filter 'test/'
	add_filter 'rdoc/'
	add_filter 'results/'
	add_filter 'coverage/'
end	

RSpec.configure do |config|
  # Only accept expect syntax do not allow old should syntax
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end