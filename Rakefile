require 'rubygems'
require 'rake'

$LOAD_PATH.unshift('lib')

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = "git-pivotal"
    gemspec.summary = "A collection of git utilities to ease integration with Pivotal Tracker"
    gemspec.description = "A collection of git utilities to ease integration with Pivotal Tracker"
    gemspec.email = "ignacio.ortega@gmail.com"
    gemspec.homepage = "http://github.com/iortega/git-pivotal"
    gemspec.authors = ["Ignacio Ortega"]
    
    gemspec.add_dependency "builder"
    gemspec.add_dependency "pivotal-tracker", "~> 0.3.1"
    
    gemspec.add_development_dependency "rspec", "~> 2.3.0"
    gemspec.add_development_dependency "rcov"
  end
  
  Jeweler::GemcutterTasks.new
rescue
  puts "Jeweler not available. Install it with: gem install jeweler"
end

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new do |t|
    t.rspec_opts = ['--color']
    t.rcov = true
    t.rcov_opts = ['--exclude', 'gems']
  end
rescue LoadError => e
  puts "RSpec not installed"
end
