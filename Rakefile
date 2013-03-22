require 'rubygems'
require 'bundler'
 
Bundler.setup
Bundler.require
 
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

desc 'Analyse the Highlight source with Excellent.'
Simplabs::Excellent::Rake::ExcellentTask.new(:excellent) do |t|
  t.paths = ['lib']
end
