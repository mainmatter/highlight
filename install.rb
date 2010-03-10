require 'fileutils'

puts ''
puts "  ** Copying highlight.css to #{RAILS_ROOT}/public/stylesheets/ **"
puts ''

FileUtils.cp(
  File.join(File.expand_path(File.dirname(__FILE__)), 'assets', 'stylesheets', 'highlight.css'),
  File.join(RAILS_ROOT, 'public', 'stylesheets')
)
