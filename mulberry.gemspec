# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mulberry/version'

Gem::Specification.new do |spec|
  spec.name          = "mulberry"
  spec.version       = Mulberry::VERSION
  spec.authors       = ["James Zhan"]
  spec.email         = ["zhiqiangzhan@gmail.com"]
  spec.description   = %q{Taggable, Commentable, Likable, Ratable, Votable, Followable, Relationships}
  spec.summary       = %q{Taggable, Commentable, Likable, Ratable, Votable, Followable, Relationships}
  spec.homepage      = "http://www.github.com/jameszhan/mulberry"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"  
  
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "factory_girl"
  spec.add_development_dependency "faker"
  spec.add_development_dependency "sqlite3"
  spec.add_development_dependency "activerecord"
end