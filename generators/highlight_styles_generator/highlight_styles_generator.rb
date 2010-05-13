if Rails::VERSION::MAJOR >= 3

  class HighlightStylesGenerator < Rails::Generators::Base

    include Rails::Generators::Actions

    def create_stylesheet_file
      empty_directory('public/stylesheets')
      copy_file(
        File.join(File.dirname(__FILE__), 'templates', 'highlight.css'),
        'public/stylesheets/highlight.css'
      )
      readme(File.join(File.dirname(__FILE__), 'templates', 'NOTES'))
    end

  end

else

  class HighlightStylesGenerator < Rails::Generator::Base

    def manifest
      record do |m|
        m.directory('public/stylesheets')
        m.file('highlight.css', 'public/stylesheets/highlight.css')
        m.readme('NOTES')
      end
    end

  end

end
