module Pajama
	class PajamaProcess < Process
		def initialize src
			super(src)
			@watermark = Magick::ImageList.new(Rc.p.watermark.p)[0]
		end

		def process write_path
			if Pa.size(@src.filename) > Rc.max_pic_size
				resize
				watermark
			else
				watermark
			end
			write write_path unless $spec_test
		end

		def resize
			@src = @src.resize(0.25)
		end

		def watermark
			# fit watermark to src width * 80%
			@watermark = @watermark.change_geometry "#{@src.columns*0.8}" do |cols,rows,img|
				img.resize(cols,rows)
			end

			# put watermark at gloden ratio
			@src = @src.composite(@watermark, Magick::SouthGravity, 0, @src.columns*0.5-@watermark.rows, Magick::OverCompositeOp)
		end

		def write *args, &blk
			@src.write *args, &blk
		end

	end
end
