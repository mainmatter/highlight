require File.dirname(__FILE__) + '/../spec_helper'

describe Simplabs::Highlight do

  before do
    @code = <<-EOC
class Test
  def method test
  end
end
EOC
  end

  describe '#highlight' do

    describe 'when Highlight is not initialized' do

      before do
        Simplabs::Highlight.initialized = false
      end

      it 'should only escape HTML in the passed code' do
        Simplabs::Highlight.initialized = false

        Simplabs::Highlight.highlight(:ruby, @code).should == CGI.escapeHTML(@code)
      end

    end

    describe 'when Highlight is initialized' do

      before do
        Simplabs::Highlight.initialized = true
      end

      it 'should initialize a Simplabs::PygmentsWrapper.highlight with the language and code' do
        wrapper = Simplabs::Highlight::PygmentsWrapper.new(@code, :ruby)

        Simplabs::Highlight::PygmentsWrapper.should_receive(:new).once.with(@code, :ruby).and_return(wrapper)

        Simplabs::Highlight.highlight(:ruby, @code)
      end

      it 'should correctly highlight source code passed as parameter' do
        Simplabs::Highlight.highlight(:ruby, @code).should == "<span class=\"k\">class</span> <span class=\"nc\">Test</span>\n  <span class=\"k\">def</span> <span class=\"nf\">method</span> <span class=\"nb\">test</span>\n  <span class=\"k\">end</span>\n<span class=\"k\">end</span>"
      end

    end

  end

end
