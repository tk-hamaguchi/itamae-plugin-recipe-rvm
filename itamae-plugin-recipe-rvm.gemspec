# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'itamae/plugin/recipe/rvm/version'

Gem::Specification.new do |spec|
  spec.name          = 'itamae-plugin-recipe-rvm'
  spec.version       = Itamae::Plugin::Recipe::Rvm::VERSION
  spec.authors       = ['Takahiro HAMAGUCHI']
  spec.email         = ['tk.hamaguchi@gmail.com']

  spec.summary       = 'RVM installer with itemae'
  spec.description   = 'RVM installer with itemae.'
  spec.homepage      = 'https://github.com/tk-hamaguchi/itamae-plugin-recipe-rvm'

  spec.licenses      = ['MIT']

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency     'itamae', '~> 1.6', '>= 1.6.1'
end
