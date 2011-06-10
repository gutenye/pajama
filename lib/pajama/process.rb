module Pajama
	class Process
		@@processors = []

		def self.inherited klass
			@@processors << klass
		end

		def self.find type
			processor = @@processors.find {|klass| klass.name=~/#{type}Process/i}
			unless processor
				raise Error, "can't find the process type -- #{type}" 
			end
			processor
		end

		def initialize pa, type, product_id, o={}
			@img = Magick::ImageList.new(pa.p)[0]
			@img_pa = pa
			@watermark = Magick::ImageList.new(Rc.p.watermark)[0] 
			@type = type
			@product_id = product_id
			@option = o
		end
	end
end

%w(pajama pajap underwear).each{|n| require_relative "process/#{n}_process"}
