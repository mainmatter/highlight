require 'simplabs/highlight'

if `which pygmentize`.blank?
  puts ''
  puts "  ** [Highlight] pygments cannot be found, highlighting code won't work! **"
  puts "  **             Get pygments from http://pygments.org. **"
  puts ''
  Simplabs::Highlight.initialized = false
else
  Simplabs::Highlight.initialized = true
end

ActionView::Base.class_eval do
  include Simplabs::Highlight::ViewMethods
end
