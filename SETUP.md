bundle gem mulberry_utils

###Setup RSpec

#####First add the following code to GEM.gemspec

~~~ruby
  spec.add_development_dependency "rspec"
~~~

#####Next, create spec/spec_helper.rb and add something like:

> rspec --init

~~~ruby
require 'rubygems'
require 'bundler/setup'

require 'your_gem_name' # and any other gems you need

RSpec.configure do |config|
  # some (optional) config here
end
~~~

