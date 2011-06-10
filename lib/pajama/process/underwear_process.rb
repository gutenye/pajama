module Pajama
	class UnderwearProcess < Process
		def self.process files, type, product_id, o={}
			Pa.mkdir_f(Rc.p.release.join(type, product_id))

			self.process_1200x files, type, product_id, o
			self.process_30x30 files, type, product_id, o
			self.process_all files, type, product_id, o
		end
		def self.process_1200x files, type, product_id, o={}
			# 00.jpg 10.jpg detail1.jpg -> 1200x
			files.find_all { |pa|
				%w(00 10 detail1).include? pa.name
			}.each { |pa|
				puts "#{type}/#{product_id}/#{pa.fname} 1200x #{o[:new] ? 'new' : ''}"
				process = self.new(pa, type, product_id, o)
				process.process_1200x
			}
		end
		def self.process_30x30 files, type, product_id, o={}
			# 10.jpg -> 30x30
			files.find_all { |pa|
				pa.name =~ /^[1-9]0$/
			}.each { |pa|
				puts "#{type}/#{product_id}/#{pa.fname} 30x30 #{o[:new] ? 'new' : ''}"
				process = self.new(pa, type, product_id, o)
				process.process_30x30
			}
		end
		def self.process_all files, type, product_id, o={}
			#
			# all.jpg -> 750x
			#
			rst_h = files.group_by { |pa| 
				if pa.name =~ /^[0-1].$/
					0
				elsif pa.name =~ /detail/
					1
				else
					2
				end
			}
			rst = rst_h.each.with_object([]){|(k,v),m| m << v.sort}.flatten
			images = []
			rst.each { |pa|
				puts "#{type}/#{product_id}/#{pa.fname} 750x #{o[:new] ? 'new' : ''}"
				process = self.new(pa, type, product_id, o)
				images << process.process_750x
			}

			# append all images into one image
			img = Magick::ImageList.new
			images.each {|image|
				img << image
			}
			img = img.append true

			puts "#{type}/#{product_id}/all.jpg 750x #{o[:new] ? 'new' : ''}"
			path = Rc.p.release.join(type, product_id, "all.jpg")
			img.write(path)
		end

		attr_reader :type
		attr_reader :product_id
		attr_reader :option

		def process_1200x
			resize "1200x"
			watermark
			write "#{@img_pa.name}_1200x.#{@img_pa.ext}"
		end

		def process_30x30
			thumbnail "30x30"
			write "#{@img_pa.name}_30x30.#{@img_pa.ext}"
		end

		def process_750x
			resize "750x"
			watermark
			compress 70
		end

		private

		def resize geometry
			@img = @img.change_geometry geometry do |cols, rows, img|
				img.resize(cols, rows)
			end
		end

		def thumbnail geometry
			@img = @img.change_geometry geometry do |cols, rows, img|
				img.thumbnail(cols, rows)
			end
		end

		def watermark
			method("watermark_#{Rc.profile}").call
		end

		def watermark_zong
			# fit watermark to src width * 80%
			@watermark = @watermark.change_geometry "#{@img.columns*0.8}" do |cols,rows,img|
				img.resize(cols,rows)
			end

			# put watermark at south end +0+100
			@img = @img.composite(@watermark, Magick::SouthGravity, 0, 100, Magick::OverCompositeOp)

		end
		def watermark_gooten
			# fit watermark to src width * 50%
			@watermark = @watermark.change_geometry "#{@img.columns*0.5}" do |cols,rows,img|
				img.resize(cols,rows)
			end

			# put watermark at south end
			@img = @img.composite(@watermark, Magick::SouthGravity, 0, 0, Magick::OverCompositeOp)
		end
		alias watermark_default watermark_gooten

		def write fname=nil
			fname ||= @img_pa.fname
			path = Rc.p.release.join(type, product_id, fname)
			@img.write(path) do |img| 
				img.quality=70 unless path.name =~ /^_/
			end unless $spec_test
			@img
		end

		def compress quality
			return if @img_pa.name =~ /^_/
			@img = Magick::Image.from_blob(@img.to_blob{|i| i.quality=quality})[0]
		end

	end
end
