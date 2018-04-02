lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pwush/version'

Gem::Specification.new do |spec|
  spec.name          = 'pwush'
  spec.version       = Pwush::VERSION
  spec.authors       = ['Yaroslav Litvinov']
  spec.email         = ['litvinov@applicot.ru']

  spec.summary       = 'Pushwoosh remote API ruby toolkit'
  spec.description   = spec.summary
  spec.homepage      = 'https://github.com/iarie/pwush'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'bin'
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'dry-monads', '~> 0.4'
  spec.add_dependency 'dry-struct', '~> 0.4'
  spec.add_dependency 'dry-types', '~> 0.12'
  spec.add_dependency 'http', '~> 3.0'
  spec.add_dependency 'oj', '~> 3'

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'pry-byebug'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rspec_junit_formatter'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'webmock', '~> 3.0'
end
