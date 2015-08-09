# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'torrentify'
  spec.version       = 0.1
  spec.authors       = ['david eriksson']
  spec.email         = ['davideriksson@swedenmail.com']

  spec.summary       = %w(Summary)
  spec.description   = %w(Description)
  spec.homepage      = 'http://seppaleinen.github.io/torrentify'

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    fail 'RubyGems 2.0 or nwr is required to protect against public gem pushes'
  end

  #spec.files         = `git ls-files`.split($\).reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.files         = `git ls-files`.split($\)
  spec.bindir        = 'bin'
  spec.executables   = ['torrentify']
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'simplecov', '>= 0.7.1', '< 1.0.0'
  spec.add_development_dependency 'mechanize', '2.7.3'
  spec.add_development_dependency 'bundler', '~> 1.10.6'
  spec.add_development_dependency 'rake', '~> 10.4.2'
  spec.add_development_dependency 'codeclimate-test-reporter', '0.4.7'
  spec.add_development_dependency 'coveralls', '0.8.2'
  #spec.add_development_dependency 'rspec', '3.3.0'
  spec.add_development_dependency 'test-unit', '3.1.2'
  spec.add_development_dependency 'rubocop', '~> 0.32.1'
end