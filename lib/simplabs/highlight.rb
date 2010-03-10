module Simplabs

  # Highlight is a simple syntax highlighting plugin for Ruby on Rails.
  # It's basically a wrapper around the popular http://pygments.org
  # highlighter that's written in Python and supports an impressive
  # number of languages.
  #
  # <b>Supported Languages</b>
  #
  # The following languages are supported. All of the paranthesized
  # identifiers may be used as parameters for the +highlight+ method to
  # denote the language the source code to highlight is written in (use
  # either Symbols or Strings).
  #
  # * Actionscript (+as+, +as3+, +actionscript+)
  # * Applescript (+applescript+)
  # * bash (+bash+, +sh+)
  # * C (+c+, +h+)
  # * Clojure (+clojure+)
  # * C++ (+c+++, +cpp+, +hpp+)
  # * C# (+c#+, +csharp+, +cs+)
  # * CSS (+css+)
  # * diff (+diff+)
  # * Dylan (+dylan+)
  # * Erlang (+erlang+, +erl+, +er+)
  # * HTML (+html+, +htm+)
  # * Java (+java+)
  # * JavaScript (+javascript+, +js+, +jscript+)
  # * JSP (+jsp+)
  # * Make (+make+, +basemake+, +makefile+)
  # * Objective-C (+objective-c+)
  # * OCaml (+ocaml+)
  # * Perl (+perl+, +pl+)
  # * PHP (+php+)
  # * Python (+python+, +py+)
  # * RHTML (+erb+, +rhtml+)
  # * Ruby (+ruby+, +rb+)
  # * Scala (+scala+)
  # * Scheme (+scheme+)
  # * Smalltalk (+smalltalk+)
  # * Smarty (+smarty+)
  # * SQL (+sql+)
  # * XML (+xml+, +xsd+)
  # * XSLT (+xslt+)
  # * YAML (+yaml+, +yml+)
  #
  module Highlight

    mattr_accessor :initialized

    SUPPORTED_LANGUAGES = {
      :as            => ['as', 'as3', 'actionscript'],
      :applescript   => ['applescript'],
      :bash          => ['bash', 'sh'],
      :c             => ['c', 'h'],
      :clojure       => ['clojure'],
      :cpp           => ['c++', 'cpp', 'hpp'],
      :csharp        => ['c#', 'csharp', 'cs'],
      :css           => ['css'],
      :diff          => ['diff'],
      :dylan         => ['dylan'],
      :erlang        => ['erlang'],
      :html          => ['html', 'htm'],
      :java          => ['java'],
      :js            => ['javascript', 'js', 'jscript'],
      :jsp           => ['jsp'],
      :make          => ['make', 'basemake', 'makefile'],
      :'objective-c' => ['objective-c'],
      :ocaml         => ['ocaml'],
      :perl          => ['perl', 'pl'],
      :php           => ['php'],
      :python        => ['python', 'py'],
      :rhtml         => ['erb', 'rhtml'],
      :ruby          => ['ruby', 'rb'],
      :scala         => ['scala'],
      :scheme        => ['scheme'],
      :smallralk     => ['smalltalk'],
      :smarty        => ['smarty'],
      :sql           => ['sql', 'mysql'],
      :xml           => ['xml', 'xsd'],
      :xslt          => ['xslt'],
      :yaml          => ['yaml', 'yml']
    }

    # Highlights the passed +code+ with the appropriate rules
    # according to the specified +language+.
    #
    # @param [Symbol, String] language
    #   the language the +code+ is in
    # @param [String] code
    #   the actual code to highlight
    #
    # @return [String]
    #   the highlighted +code+
    #
    def self.highlight(language, code)
      return CGI.escapeHTML(code) unless Simplabs::Highlight.initialized
      Simplabs::Highlight::PygmentsWrapper.new(code, language).highlight
    end

    # View Helpers for using {Highlight} in Ruby on Rails templates.
    #
    module ViewMethods

      # Highlights the passed +code+ with the appropriate rules
      # according to the specified +language+. The code can be specified
      # either as a string or provided in a block.
      #
      # @example Specifying the code to highlight as a String
      #
      #  highlight(:ruby, 'class Test; end')
      #
      # @example Specifying the code to highlight in a block
      #
      #  highlight(:ruby) do
      #    klass = 'class'
      #    name  = 'Test'
      #    _end  = 'end'
      #    "#{klass} #{name}; #{_end}"
    	#  end 
    	#
    	# @raise [ArgumentError] if both the +code+ parameter and a block are given
    	# @raise [ArgumentError] if neither the +code+ parameter or a block are given
    	#
    	# @see Simplabs::Highlight.highlight
    	#
      def highlight(language, code = nil, &block)
        raise ArgumentError.new('Either pass a srting containing the code or a block, not both!') if !code.nil? && block_given?
        raise ArgumentError.new('Pass a srting containing the code or a block!') if code.nil? && !block_given?
        code ||= yield
        Simplabs::Highlight.highlight(language, code)
      end

    end

  end

end
