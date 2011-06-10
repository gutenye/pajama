module Pajama
	class Process
		@@processors = []

		def self.inherited klass
			@@processors << klass
		end

		def self.find profile
			processor = @@processors.find {|klass| klass.name=~/#{profile}Process/i}
			unless processor
				raise Error, "can't find the profile -- #{profile}" 
			end
			processor
		end

		def initialize profile, pa, type, product_id, watermark_pa=nil, o={}
			@profile = profile
			@img = Magick::ImageList.new(pa.p)[0]
			@img_pa = pa
			@watermark = Magick::ImageList.new(watermark_pa.p)[0] if watermark_pa
			@type = type
			@product_id = product_id
			@option = o
		end
	end
end

%w(pajama pajap underwear).each{|n| require_relative "process/#{n}_process"}
