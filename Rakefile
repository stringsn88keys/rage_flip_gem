require 'rake'
require 'rake/testtask'
require 'rspec/core/rake_task'
require_relative 'lib/rage_flip/version'

# Define the default task
task :default => :test

# Define a task for running tests with RSpec
RSpec::Core::RakeTask.new(:test) do |t|
  t.pattern = 'spec/**/*_spec.rb'
end

# Alias for backwards compatibility
task :spec => :test

# Define a task for building the gem
task :build do
  sh 'gem build rage_flip.gemspec'
end

# Define a task for installing the gem
task :install do
  sh 'gem install rage_flip-*.gem'
end

# Define a task for cleaning up generated files
task :clean do
  rm_rf Dir['*.gem']
end

# Define a task for running all tasks
task :all => [:build, :install, :test]

# Version management tasks
namespace :version do
  desc "Show current version"
  task :show do
    puts "Current version: #{RageFlip::VERSION}"
  end

  desc "Bump patch version (0.1.0 -> 0.1.1)"
  task "bump:patch" do
    bump_version(:patch)
  end

  desc "Bump minor version (0.1.0 -> 0.2.0)"
  task "bump:minor" do
    bump_version(:minor)
  end

  desc "Bump major version (0.1.0 -> 1.0.0)"
  task "bump:major" do
    bump_version(:major)
  end

  desc "Set specific version"
  task :set, [:version] do |t, args|
    if args[:version].nil?
      puts "Usage: rake version:set[1.2.3]"
      exit 1
    end
    
    unless args[:version].match?(/^\d+\.\d+\.\d+$/)
      puts "Error: Version must be in format X.Y.Z (e.g., 1.2.3)"
      exit 1
    end
    
    update_version_file(args[:version])
    puts "Version set to #{args[:version]}"
  end
end

# Release task
desc "Build gem, run tests, and create git tag"
task :release do
  # Ensure working directory is clean
  unless `git status --porcelain`.strip.empty?
    puts "Error: Working directory is not clean. Commit or stash changes first."
    exit 1
  end

  # Run tests
  Rake::Task[:test].invoke
  puts "✓ Tests passed"

  # Build gem
  Rake::Task[:build].invoke
  puts "✓ Gem built"

  # Create git tag
  version = RageFlip::VERSION
  `git tag -a v#{version} -m "Release v#{version}"`
  puts "✓ Git tag v#{version} created"

  puts "\nRelease v#{version} ready!"
  puts "To push: git push origin main --tags"
  puts "To publish: gem push rage_flip-#{version}.gem"
end

# Helper method to bump version
def bump_version(type)
  current_version = read_current_version
  current = current_version.split('.').map(&:to_i)
  
  case type
  when :patch
    current[2] += 1
  when :minor
    current[1] += 1
    current[2] = 0
  when :major
    current[0] += 1
    current[1] = 0
    current[2] = 0
  end
  
  new_version = current.join('.')
  update_version_file(new_version)
  puts "Version bumped from #{current_version} to #{new_version}"
end

# Helper method to read current version from file
def read_current_version
  version_file = 'lib/rage_flip/version.rb'
  content = File.read(version_file)
  content.match(/VERSION = "([^"]+)"/)[1]
end

# Helper method to update version file
def update_version_file(new_version)
  version_file = 'lib/rage_flip/version.rb'
  content = File.read(version_file)
  
  updated_content = content.gsub(
    /VERSION = "[^"]+"/, 
    "VERSION = \"#{new_version}\""
  )
  
  File.write(version_file, updated_content)
end