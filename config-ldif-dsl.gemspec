# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ldif/version'

Gem::Specification.new do |spec|
  spec.name          = "config-ldif-dsl"
  spec.version       = Ldif::VERSION
  spec.authors       = ["Ilya Kamenko"]
  spec.email         = ["i.kamenko@itransition.com"]
  spec.description   = %q{Config ldif dsl}
  spec.summary       = %q{Config ldif dsl}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "docile"
  spec.add_development_dependency 'rspec', ['>= 0']
  spec.add_development_dependency 'ladle'
end
