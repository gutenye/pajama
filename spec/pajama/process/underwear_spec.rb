require "spec_helper"
require "pajama/process"

Underwear = Pajama::Process::Underwear

class Underwear
  public :resize, :thumbnail, :do_watermark, :compress, :write
end

describe Underwear do
	before :each do
		Pa.cp "#{$spec_data}/source-gooten", "#{$spec_data}/gooten"
	end

	after :each do
		Pa.rm_r "#{$spec_data}/gooten"
	end

  xdescribe "watermark" do
    it "works" do
      u = Underwear.new(Pa("#{$spec_data}/gooten/new/jz13/pro.10.jpg"))
      u.resize "750x"
      u.do_watermark 0.8, "Center", 0, 0
      u.image.display
    end
  end

	xdescribe ".process_all" do
		it "works" do
      files = Pa.ls("#{$spec_data}/gooten/new/jz13", :absolute => true)
			Underwear.process_all(*files)

			`feh --scale-down #{$spec_data}/gooten/new/jz13/tao.all.jpg`
		end
	end

  xdescribe ".process_1200x" do
    it "works" do
      files = [Pa("#{$spec_data}/gooten/new/jz13/pro.10.jpg")]
      Underwear.process_1200x(*files)

      puts Pa.ls "#{$spec_data}/gooten/new/jz13"

      `feh --scale-down #{$spec_data}/gooten/new/jz13/tao.10_1200x.jpg`
    end
  end

  xdescribe ".process_30x30" do
    it "works" do
      files = [Pa("#{$spec_data}/gooten/new/jz13/pro.10.jpg")]
      Underwear.process_30x30(*files)

      `feh --scale-down #{$spec_data}/gooten/new/jz13/tao.10_30x30.jpg`
    end
  end
end
