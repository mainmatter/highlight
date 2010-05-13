plugin_root = File.join(File.dirname(__FILE__), '..')

$:.unshift "#{plugin_root}/lib"

Bundler.require
require 'initializer'

RAILS_ROOT = File.expand_path(File.dirname(__FILE__) + '/../')
Rails::Initializer.run(:set_load_path)
Rails::Initializer.run(:set_autoload_paths)

require File.join(File.dirname(__FILE__), '/../rails/init.rb')

FileUtils.mkdir_p(File.join(File.dirname(__FILE__), 'log'))
