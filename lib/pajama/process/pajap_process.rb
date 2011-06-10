module Pajama
	class PajapProcess < Process

		def process write_path
			rotate
			resize
			extent
			write(write_path){|info| info.quality=80} unless $spec_test
		end

		def rotate
			@src = @src.rotate(-90, "<") || @src
		end

		def resize 
			@src = @src.change_geometry "x135" do |cols,rows,img|
				img.resize cols, rows
			end
		end

		def extent
			w,h = [216, 135]
			@src = @src.extent(w,h, *compute_center([w,h], [@src.columns, @src.rows]))
		end

		def write *args, &blk
			@src.write *args, &blk
		end

		#
		# @param [Array] bg_wh [w,h]
		# @param [Array] fg_wh [w,h]
		#
		def compute_center(bg_wh, fg_wh)
			bg_w,bg_h = bg_wh
			fg_w,fg_h = fg_wh
			[-(bg_w-fg_w)/2.0, -(bg_h-fg_h)/2.0]
		end
	end
end
