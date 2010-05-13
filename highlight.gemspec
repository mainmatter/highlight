# -*- encoding: utf-8 -*-

pkg_files = [
  'README.md',
  'HISTORY.md',
  'Rakefile',
  'MIT-LICENSE'
]
pkg_files += Dir['generators/**/*']
pkg_files += Dir['lib/**/*.rb']
pkg_files += Dir['rails/**/*.rb']
pkg_files += Dir['spec/**/*.{rb,yml,opts}']

Gem::Specification.new do |s|

  s.name    = %q{highlight}
  s.version = '1.1.2'

  s.required_rubygems_version = Gem::Requirement.new('>= 0') if s.respond_to?(:required_rubygems_version=)
  s.authors                   = ['Marco Otte-Witte']
  s.date                      = %q{2010-05-13}
  s.email                     = %q{info@simplabs.com}
  s.files                     = pkg_files
  s.homepage                  = %q{http://github.com/simplabs/highlight}
  s.require_path              = 'lib'
  s.rubygems_version          = %q{1.3.0}
  s.has_rdoc                  = false
  s.summary                   = %q{Syntax Higlighting plugin for Ruby on Rails }
  s.description               = %q{Highlight highlights code in more than 20 languages. It uses the Pygments syntax highlighter and adds a simple Ruby API over it. It also provides helpers for use in your Ruby on Rails views.}

  if s.respond_to?(:specification_version) then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2
    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>, ['>= 2.0.0'])
    else
      s.add_dependency(%q<activesupport>, ['>= 2.0.0'])
    end
  else
    s.add_dependency(%q<activesupport>, ['>= 2.0.0'])
  end

end
