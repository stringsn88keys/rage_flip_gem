require 'rake'
require 'rake/testtask'

# Define the default task
task :default => :test

# Define a task for running tests
Rake::TestTask.new(:test) do |t|
  t.pattern = 'spec/*_spec.rb'
end

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