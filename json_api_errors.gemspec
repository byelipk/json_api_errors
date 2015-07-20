# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'json_api_errors/version'

Gem::Specification.new do |spec|
  spec.name          = "json_api_errors"
  spec.version       = JsonApiErrors::VERSION
  spec.authors       = ["byelipk"]
  spec.email         = ["byelipk@gmail.com"]

  spec.summary       = %q{A simple wrapper around the JsonAPI Error spec.}
  spec.description   = %q{While building out a backend server I realized a needed a simple way to generate error responses in the JsonAPI format. So I made this library and decided to publish it as a gem. (It's my first!)}
  spec.homepage      = "https://github.com/byelipk/json_api_errors"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency 'minitest', '~> 0'
end
