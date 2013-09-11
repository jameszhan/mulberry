# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mulberry_utils/version'

Gem::Specification.new do |spec|
  spec.name          = "mulberry_utils"
  spec.version       = MulberryUtils::VERSION
  spec.authors       = ["James Zhan"]
  spec.email         = ["zhiqiangzhan@gmail.com"]
  spec.description   = %q{Taggable, Commentable, Likable, Votable}
  spec.summary       = %q{Taggable, Commentable, Likable, Votable}
  spec.homepage      = "http://www.github.com/jameszhan/mulberry_utils"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  
  spec.add_development_dependency "rspec"
end
