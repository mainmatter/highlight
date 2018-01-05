require 'spec_helper'
require 'webmock/rspec'

describe Simplabs::Highlight do

  let(:code) do
    <<-EOC
class Test
  def method test
  end
end
EOC
  end

  describe '#highlight' do

    shared_examples 'the highlight method' do

      describe 'when the language is not supported' do

        it 'should only escape HTML in the passed code' do
          expect(Simplabs::Highlight.highlight(:unsupported, code)).to eq(CGI.escapeHTML(code))
        end

      end

      describe 'when the language is supported' do

        it 'should correctly highlight source code passed as parameter' do
          expect(Simplabs::Highlight.highlight(:ruby, code)).to eq(
            %Q(<span class="k">class</span> <span class="nc">Test</span>\n  <span class="k">def</span> <span class="nf">method</span> <span class="nb">test</span>\n  <span class="k">end</span>\n<span class="k">end</span>)
          )
        end

      end

    end

    describe 'when pygments is used directly' do

      before do
        Simplabs::Highlight.use_web_api = false
      end

      it_behaves_like 'the highlight method'

      it 'should initialize a Simplabs::PygmentsWrapper.highlight with the language and code' do
        wrapper = Simplabs::Highlight::PygmentsWrapper.new(code, :ruby)

        Simplabs::Highlight::PygmentsWrapper.should_receive(:new).once.with(code, :ruby).and_return(wrapper)

        Simplabs::Highlight.highlight(:ruby, code)
      end

    end

    describe 'when the web API is used' do

      before do
        Simplabs::Highlight.use_web_api = true
        stub_request(:post, Simplabs::Highlight::WEB_API_URL).to_return({
          body: %Q(<span class="k">class</span> <span class="nc">Test</span>\n  <span class="k">def</span> <span class="nf">method</span> <span class="nb">test</span>\n  <span class="k">end</span>\n<span class="k">end</span>),
          status: 200
        })
      end

      it_behaves_like 'the highlight method'

    end

  end

  describe '.get_language_sym' do

    describe 'for an unsupported language' do

      it 'should return false' do
        expect(Simplabs::Highlight.send(:get_language_sym, 'unsupported language')).to be_false
      end

    end

    describe 'for a supported language' do

      it 'should return the respective symbol when the languages was given as String' do
        expect(Simplabs::Highlight.send(:get_language_sym, 'ruby')).to eq(:ruby)
      end

      it 'should return the respective symbol when the languages was given as Symbol' do
        expect(Simplabs::Highlight.send(:get_language_sym, :rb)).to eq(:ruby)
      end

    end

  end

end
