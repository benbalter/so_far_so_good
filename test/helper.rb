require 'rubygems'
require 'bundler'
require 'minitest/autorun'
require 'shoulda'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require './lib/so_far_so_good.rb'
