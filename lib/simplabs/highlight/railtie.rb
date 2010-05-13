require 'simplabs/highlight'
require 'rails'

module Simplabs

  module Highlight

    class Railtie < Rails::Railtie

      GEM_ROOT = File.join(File.dirname(__FILE__), '..', '..', '..')

      initializer 'simplabs.highlight.initialization' do
        require File.join(GEM_ROOT, 'rails', 'init')
      end

      generators do
        require File.join(GEM_ROOT, 'generators', 'highlight_styles_generator', 'highlight_styles_generator')
      end

    end

  end

end
