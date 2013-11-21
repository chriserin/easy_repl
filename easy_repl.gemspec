# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'easy_repl/version'

Gem::Specification.new do |spec|
  spec.name          = "easy_repl"
  spec.version       = EasyRepl::VERSION
  spec.authors       = ["Christopher Erin"]
  spec.email         = ["chris.erin@gmail.com"]
  spec.description   = %q{easy repl}
  spec.summary       = %q{easy repl}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"
end
