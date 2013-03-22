notification :growl

guard :rspec do
  watch(%r{^lib/(.+)\.rb$})     { 'spec' }
  watch(%r{^generators/(.+)$})  { 'spec' }
  watch('spec/spec_helper.rb')  { 'spec' }
  watch(%r{^spec/.+_spec\.rb$})
end
