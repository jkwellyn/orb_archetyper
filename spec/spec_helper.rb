require 'simplecov'
SimpleCov.start do 

	coverage_dir 'tmp/coverage/unit'

	add_filter 'spec/'
	add_filter 'test/'
	add_filter 'rdoc/'
	add_filter 'results/'
	add_filter 'coverage/'
end	