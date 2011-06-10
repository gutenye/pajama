require "bundler/setup"
Bundler.require

module Pajama
	Error = Class.new Exception
end

%w(cli picture process util rc).each {|n| require_relative "pajama/#{n}"}

# load profile
#load Pa.join(ENV["HOME"], ".pajama/#{$profile}")
