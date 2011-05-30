module Pajama
	class Rc
		def self.mount_point; Pa("/media/camera/DCIM/101MSDCF") end
		def self.pic_dir; Pa(ENV["HOME"]).join("buss/pajama/pic") end
		def self.tmp_dir; Pa("/tmp/pajama_pic") end

	end
end
