libdir = File.dirname(__FILE__); $LOAD_PATH.unshift(libdir) unless $LOAD_PATH.include?(libdir)

require "pd"
require "tagen/core"
require "pa"
require "optimism"

module Pajama
  autoload :VERSION, "pajama/version"
  autoload :UI, "pajama/ui"
  autoload :CLI, "pajama/cli"
  autoload :Picture, "pajama/picture"
  autoload :Process, "pajama/process"
  autoload :Util, "pajama/util"

  Error = Class.new Exception
  EFatal = Class.new Exception
  Rc = Optimism.require "pajama/rc"

  class << self
    attr_accessor :ui

    def ui
      @ui ||= UI.new
    end
  end
end
