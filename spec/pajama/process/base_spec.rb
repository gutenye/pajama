require "spec_helper"
require "pajama/process"

Base = Pajama::Process::Base
class Base
	public :resize, :thumbnail, :do_watermark, :compress, :write
end

describe Base do
  describe "#resize" do
    it "works" do
      p = Base.new(Pa("#{$spec_data}/pro.10.jpg"), nil, nil)
      p.resize "100x100"

      p.image.cr.should == [100, 71]
    end
  end

  describe "#thumbnail" do
    it "works" do
      p = Base.new(Pa("#{$spec_data}/pro.10.jpg"), nil, nil)
      p.thumbnail "30x30"

      p.image.cr.should == [30, 21]
    end
  end

  describe "#do_watermark" do
    it "works" do
      p = Base.new(Pa("#{$spec_data}/pro.10.jpg"), nil, nil)
      origin_size = p.image.filesize

      p.do_watermark(0.8, 0, 100)

      #p.image.display
      #p.image.filesize.should > origin_size # go 0
    end
  end

  describe "#compress" do
    it "works" do
      p = Base.new(Pa("#{$spec_data}/pro.10.jpg"), nil, nil)
      origin_size = p.image.filesize
      p.compress 70

      p.image.filesize.should < origin_size
    end
  end

  describe "#write" do
    it "works" do
      p = Base.new(Pa("#{$spec_data}/pro.10.jpg"), nil, nil)

      begin
        p.write("foo.jpg")
        Pa("#{$spec_data}/tao.foo.jpg").should be_exists
      ensure
        Pa.rm_f Pa"#{$spec_data}/tao.foo.jpg"
      end
    end
  end
end
