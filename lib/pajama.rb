require "tagen/core"
require "thor"

%w(cli picture util rc).each {|n| require_relative "pajama/#{n}"}
