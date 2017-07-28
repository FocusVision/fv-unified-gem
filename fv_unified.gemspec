# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fv/unified/version'

Gem::Specification.new do |spec|
  spec.name          = 'fv_unified'
  spec.version       = FV::Unified::VERSION
  spec.authors       = ['FocusVision']
  spec.email         = ['portlanddevelopers@focusvision.com']

  spec.summary       = 'SDK for FocusVision unified login api'
  spec.description   = 'The fv_unified gem wraps the FV Unified Login API in ' \
    'simple method calls'
  spec.homepage      = 'https://invent.focusvision.com/Portland/fv-unified'

  spec.metadata['allowed_push_host'] = 'http://gems.focusvision.com'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'fv'

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'pry-inline', '~> 1.0.2'
  spec.add_development_dependency 'webmock', '~> 2.3.1'
end
