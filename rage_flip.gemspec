require_relative 'lib/rage_flip/version'

Gem::Specification.new do |spec|
  spec.name          = "rage_flip"
  spec.version       = RageFlip::VERSION
  spec.authors       = ["Your Name"]
  spec.email         = ["your.email@example.com"]
  spec.summary       = "A gem that flips arguments and copies the result to the clipboard."
  spec.description   = "The rage_flip gem takes all arguments passed to it, flips them, and copies the result to the clipboard using platform-specific commands."
  spec.homepage      = "https://github.com/yourusername/rage_flip"
  spec.license       = "MIT"

  spec.files         = Dir["lib/**/*", "bin/*", "exe/*", "README.md", "Rakefile", "Gemfile", "spec/**/*"]
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end