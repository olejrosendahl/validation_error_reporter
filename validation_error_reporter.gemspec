# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'validation_error_reporter/version'

Gem::Specification.new do |spec|
  spec.name          = "validation_error_reporter"
  spec.version       = ValidationErrorReporter::VERSION
  spec.authors       = ["Ole J. Rosendahl"]
  spec.email         = ["ole.johnny.rosendahl@gmail.com"]
  spec.summary       = "Find and report ActiveRecord validation errors."
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/olejrosendahl/validation_error_reporter"
  spec.license       = "MIT"
  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 1.9.3'

  spec.add_dependency "rails", ">= 3.2", "< 5.0"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.2"
  spec.add_development_dependency "sqlite3", '~> 1.0'
  spec.add_development_dependency "database_cleaner", '~> 1.0'
  spec.add_development_dependency "coveralls"
end
