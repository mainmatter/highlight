$:.reject! { |e| e.include? 'TextMate' }

ENV['RAILS_ENV'] = 'test'

require 'rubygems'
require 'bundler'
Bundler.setup

require File.join(File.dirname(__FILE__), 'boot')
