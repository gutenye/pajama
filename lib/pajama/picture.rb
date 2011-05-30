module Pajama
	class Picture
		def self.mv_pic
			Pa.mv Rc.mount_point.join("/*.JPG"), Rc.pic_dir.join("/new")
		end

		# @type: :erp :taobao
		#
		def self.process type
			Pa.mkdir_f Rc.tmp_dir 

			Pa.each Rc.pic_dir.join("/new") do |pa|
				next if pa.ext !~ /jpg/i
				puts "convert #{pa.base}"
				case type
				when :erp
					`convert #{pa.p} -resize x135  -gravity center -extent 216x135 -quality 80 #{Rc.tmp_dir}/#{pa.base}`
					Pa.mv_f pa.p, Rc.pic_dir.join("/erp")
				end

			end
		end

	end
end
