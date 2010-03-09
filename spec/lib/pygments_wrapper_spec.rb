require File.dirname(__FILE__) + '/../spec_helper'

describe Simplabs::Highlight::PygmentsWrapper do

  before do
    @wrapper = Simplabs::Highlight::PygmentsWrapper.new('class Test; end', :ruby)
  end

  describe '#get_language_sym' do

    it 'should return false if the specified language is not supported' do
      @wrapper.send(:get_language_sym, 'unsupported language').should == false
    end

    it 'should return the respective symbol if the specified language is given as string and is supported' do
      @wrapper.send(:get_language_sym, 'ruby').should == :ruby
    end

    it 'should return the respective symbol if the specified language is given as symbol and is supported' do
      @wrapper.send(:get_language_sym, :rb).should == :ruby
    end

  end

  describe '#highlight' do

    it 'should return the CGI-escaped code if the specified language is not supported' do
      @wrapper = Simplabs::Highlight::PygmentsWrapper.new('class Test; end', 'unsupported language')

      @wrapper.highlight.should == CGI.escapeHTML(@wrapper.code)
    end

    it 'should create temporary file'

    it 'should write the code to the created file'

  end

end
