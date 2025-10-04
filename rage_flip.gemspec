require_relative 'lib/rage_flip/version'

Gem::Specification.new do |spec|
  spec.name          = "rage_flip"
  spec.version       = RageFlip::VERSION
  spec.authors       = ["Thomas Powell"]
  spec.email         = ["twilliampowell@gmail.com"]
  spec.summary       = "A gem that manipulates text in various fun ways."
  spec.description   = "The rage_flip gem provides various text manipulation utilities with clipboard integration."
  spec.homepage      = "https://github.com/stringsn88keys/rage_flip_gem"
  spec.license       = "MIT"

  spec.files         = Dir["lib/**/*", "bin/*", "exe/*", "README.md", "CHANGELOG.md", "Rakefile", "Gemfile", "spec/**/*"]
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rake", "~> 13.0"
end