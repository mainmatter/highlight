require File.dirname(__FILE__) + '/../spec_helper'

describe Simplabs::Highlight::PygmentsWrapper do

  before do
    @wrapper = Simplabs::Highlight::PygmentsWrapper.new('class Test; end', :ruby)
  end

  describe '#get_language_sym' do

    describe 'for an unsupported language' do

      it 'should return false' do
        @wrapper.send(:get_language_sym, 'unsupported language').should == false
      end

    end

    describe 'for a supported language' do

      it 'should return the respective symbol when the languages was given as String' do
        @wrapper.send(:get_language_sym, 'ruby').should == :ruby
      end

      it 'should return the respective symbol when the languages was given as Symbol' do
        @wrapper.send(:get_language_sym, :rb).should == :ruby
      end

    end

  end

  describe '#highlight' do

    describe 'for an unsupported language' do

      it 'should return the CGI-escaped code if the specified language is not supported' do
        @wrapper = Simplabs::Highlight::PygmentsWrapper.new('class Test; end', 'unsupported language')

        @wrapper.highlight.should == CGI.escapeHTML(@wrapper.code)
      end

    end

    describe 'for a supported language' do

      before do
        @temp_file = Tempfile.new('simplabs_highlight')
        Tempfile.stub!(:new).and_return(@temp_file)
      end

      it 'should create a temporary file' do
        @wrapper.highlight

        File.exists?(@temp_file.path).should be_true
      end

      it 'should write the code to the created file' do
        @wrapper.highlight

        File.read(@temp_file.path).should == "#{@wrapper.code}\n"
      end

    end

  end

end
