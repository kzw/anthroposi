version=0.0.1
gem_file=anthroposi-$(version).gem
$(gem_file): lib/anthroposi.rb anthroposi.gemspec
	gem build anthroposi.gemspec
clean:
	\rm anthroposi*.gem test
test: lib/anthroposi.rb tests/anthroposi_spec.rb makefile
	rspec -I lib tests; touch test
