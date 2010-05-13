require 'action_view'
require 'simplabs/highlight'

if `which pygmentize`.blank?
  puts ''
  puts "  ** [Highlight] pygments cannot be found, falling back to #{Simplabs::Highlight::WEB_API_URL}! **"
  puts '  **             If you have pygments installed, make sure it is in your PATH.           **'
  puts ''
  Simplabs::Highlight.use_web_api = true
else
  Simplabs::Highlight.use_web_api = false
end

ActionView::Base.class_eval do
  include Simplabs::Highlight::ViewMethods
end
