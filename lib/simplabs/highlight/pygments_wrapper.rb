module Simplabs

  module Highlight

    # Wraps the actual +pygments+ syntax highlighter and
    # exposes its functionality to Ruby code.
    #
    class PygmentsWrapper

      # The code the wrapper highlights
      #
      attr_reader :code

      # The language the {Simplabs::Highlight::PygmentsWrapper#code} to highlight is in
      #
      attr_reader :language

      # Initializes a new {Simplabs::Highlight::PygmentsWrapper}.
      #
      # @param [String] code
      #   the actual code to highlight
      # @param [String, Symbol] language
      #   the language the +code+ to highlight is in
      #
      def initialize(code, language)
        @code     = code
        @language = language
      end

      # Highlights the {Simplabs::Highlight::PygmentsWrapper#code}.
      #
      # @return [String]
      #   the highlighted code or simply the HTML-escaped code
      #   if the language is not supported.
      #
      def highlight
        command = "pygmentize -f html -O nowrap=true -l #{@language}"
        IO.popen(command, mode = 'r+') do |pygments|
          pygments << @code
          pygments.close_write
          pygments.read.strip.chomp
        end
      end

    end

  end

end
