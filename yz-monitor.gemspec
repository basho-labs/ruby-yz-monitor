# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require './lib/yz-monitor/version'

Gem::Specification.new do |spec|
  spec.name          = "yz-monitor"
  spec.version       = Riak::Yokozuna::Monitor::VERSION
  spec.authors       = ["Bryce Kerley"]
  spec.email         = ["bkerley@brycekerley.net"]
  spec.summary       = %q{Sensu-style monitoring tools for Riak Search 2}
  spec.description   = %q{Sensu-style monitoring tools for Riak Search 2}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_dependency 'riak-client', '2.2.0.pre1'
  spec.add_dependency 'sensu-plugin', '~> 1.1.0''
end
