require 'cgi'

module Simplabs

  module Highlight

    class PygmentsWrapper #:nodoc:

      class << self

        def highlight(code, language)
          return CGI.escapeHTML(code) if !(language = get_language_sym(language))
          tempfile = Tempfile.new('simplabs_highlight')
          File.open(tempfile.path, 'w') do |f|
            f << code
            f << "\n"
          end
          result = `pygmentize -f html -O nowrap=true -l #{language} #{tempfile.path}`
          result.chomp
        end

        protected

          def get_language_sym(name)
            Simplabs::Highlight::SUPPORTED_LANGUAGES.each_pair do |key, value|
              return key if value.any? { |lang| lang == name.to_s }
            end
            return false
          end

      end

    end

  end

end
