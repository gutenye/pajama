require "stringio"
require "bundler/setup"
require "pajama"

$spec_dir = File.expand_path("..", __FILE__)
$spec_data = File.expand_path("../data", __FILE__)

Rc = Pajama::Rc
Rc._merge! Optimism <<EOF
p:
	project = Pa("#{$spec_data}/gooten")
  home = Pa("#{$spec_data}/_pajama")

  new = Pa("#{$spec_data}/gooten/new")
	release = Pa("#{$spec_data}/gooten/release")
  archive = project

	mount_point  = Pa("#{$spec_data}/camera")
	watermark = Pa("#{$spec_data}/watermarks/gooten.png")

o:
  watermark = [0.8, "Center", 0, 0]
EOF

RSpec.configure do |config|
  def capture(stream)
    begin
      stream = stream.to_s
      eval "$#{stream} = StringIO.new"
      yield
      result = eval("$#{stream}").string
    ensure
      eval("$#{stream} = #{stream.upcase}")
    end

    result
  end

  alias :silence :capture
end

module Kernel 
private

  def xdescribe(*args, &blk)
    describe *args do
      pending "xxxxxxxxx"
    end
  end

  def xcontext(*args, &blk)
    context *args do
      pending "xxxxxxxxx"
    end
  end

  def xit(*args, &blk)
    it *args do
      pending "xxxxxxxx"
    end
  end
end
