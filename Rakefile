require 'rubygems'
require 'bundler'
 
Bundler.setup
Bundler.require
 
require 'spec/rake/spectask'
require 'simplabs/excellent/rake'
 
desc 'Default: run specs.'
task :default => :spec

desc 'Run the specs'
Spec::Rake::SpecTask.new(:spec) do |t|
  t.rcov_opts  << '--exclude "gems/*,spec/*,init.rb"'
  t.rcov       = true
  t.rcov_dir   = 'doc/coverage'
  t.spec_files = FileList['spec/**/*_spec.rb']
end

desc 'Generate The Highlight documentation'
YARD::Rake::YardocTask.new(:doc) do |t|
  t.files   = ['lib/**/*.rb']
  t.options = ['--no-private', '--title', 'Highlight Documentation']
end

desc 'Analyse the Highlight source with Excellent.'
Simplabs::Excellent::Rake::ExcellentTask.new(:excellent) do |t|
  t.paths = ['lib']
end
