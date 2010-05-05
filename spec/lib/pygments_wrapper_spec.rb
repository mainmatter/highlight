require File.dirname(__FILE__) + '/../spec_helper'

describe Simplabs::Highlight::PygmentsWrapper do

  before do
    code = <<-EOC
class Test
  def method test
  end
end
EOC
    @wrapper = Simplabs::Highlight::PygmentsWrapper.new(code, :ruby)
  end

  describe '#highlight' do

    it 'should correctly highlight source code passed as parameter' do
      @wrapper.highlight.should == %Q(<span class="k">class</span> <span class="nc">Test</span>\n  <span class="k">def</span> <span class="nf">method</span> <span class="nb">test</span>\n  <span class="k">end</span>\n<span class="k">end</span>)
    end

  end

end
