require 'spec_helper'

describe Simplabs::Highlight::ViewMethods do

  include Simplabs::Highlight::ViewMethods

  let(:code) { 'class Test; end' }

  describe '#highlight_code' do

    describe 'when invoked with a language and a string' do

      it 'should highlight the code' do
        Simplabs::Highlight.should_receive(:highlight).once.with(:ruby, code)

        highlight_code(:ruby, code)
      end

    end

    describe 'when invoked with a language and a block' do

      it 'should highlight the code' do
        Simplabs::Highlight.should_receive(:highlight).once.with(:ruby, code)

        highlight_code(:ruby) do
          code
        end
      end

    end

    describe 'when invoked with both a string and a block' do

      it 'should raise an ArgumentError' do
        expect { highlight_code(:ruby, code) { code } }.to raise_error(ArgumentError)
      end

    end

    describe 'when invoked with neither a string nor a block' do

      it 'should raise an ArgumentError' do
        expect { highlight_code(:ruby) }.to raise_error(ArgumentError)
      end

    end

  end

end
