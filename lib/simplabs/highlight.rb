require 'cgi'
require 'net/http'
require 'uri'
require 'active_support/core_ext/module/attribute_accessors'
require 'simplabs/highlight/pygments_wrapper'

module Simplabs

  require 'simplabs/highlight/railtie' if defined?(Rails) && Rails::VERSION::MAJOR >= 3

  # Highlight is a simple syntax highlighting plugin for Ruby on Rails.
  # It's basically a wrapper around the popular http://pygments.org
  # highlighter that's written in Python and supports an impressive
  # number of languages. If pygments is installed on the machine and in
  # the +PATH+, that binary is used, otherwise the plugin falls back
  # to the web API at (http://pygments.appspot.com/), created by Trevor
  # Turk.
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

    mattr_accessor :use_web_api

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

    WEB_API_URL = 'http://pygments.appspot.com/'

    # Highlights the passed +code+ with the appropriate rules
    # according to the specified +language+.
    #
    # @param [Symbol, String] language
    #   the language the +code+ is in
    # @param [String] code
    #   the actual code to highlight
    #
    # @return [String]
    #   the highlighted +code+ or simply the HTML-escaped code if +language+
    #   is not supported.
    #
    def self.highlight(language, code)
      language = get_language_sym(language)
      return CGI.escapeHTML(code) unless language
      if Simplabs::Highlight.use_web_api
        highlight_with_web_api(language, code)
      else
        Simplabs::Highlight::PygmentsWrapper.new(code, language).highlight
      end
    end

    # View Helpers for using {Highlight} in Ruby on Rails templates.
    #
    module ViewMethods

      # Highlights the passed +code+ with the appropriate rules
      # according to the specified +language+. The code can be specified
      # either as a string or provided in a block.
      #
      # @param [Symbol, String] language
      #   the language the +code+ is in
      # @param [String] code
      #   the actual code to highlight
      # @yield
      #   the +code+ can also be specified as result of a given block.
      #
      # @return [String]
      #   the highlighted +code+ or simply the HTML-escaped code if +language+
      #   is not supported.
      #
      # @example Specifying the code to highlight as a String
      #
      #  highlight_code(:ruby, 'class Test; end')
      #
      # @example Specifying the code to highlight in a block
      #
      #  highlight_code(:ruby) do
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
      def highlight_code(language, code = nil, &block)
        raise ArgumentError.new('Either pass a srting containing the code or a block, not both!') if !code.nil? && block_given?
        raise ArgumentError.new('Pass a srting containing the code or a block!') if code.nil? && !block_given?
        code ||= yield
        Simplabs::Highlight.highlight(language, code)
      end

    end

    private

      def self.highlight_with_web_api(language, code)
        request = Net::HTTP.post_form(URI.parse(WEB_API_URL), {
          'lang' => language,
          'code' => code
        })
        request.body.gsub(/\A\<div class=\"highlight\"\>\<pre\>/, '').gsub(/\n\<\/pre\>\<\/div\>\n/, '')
      end

      def self.get_language_sym(name)
        SUPPORTED_LANGUAGES.each_pair do |key, value|
          return key if value.any? { |lang| lang == name.to_s }
        end
        return false
      end

  end

end
