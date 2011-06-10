module Pajama
	class Rc
		def self.mount_point; Pa("/media/camera/DCIM/101MSDCF") end
		def self.pic_dir; Pa(ENV["HOME"]).join("pajama/pic") end
		def self.release_pa; self.pic_dir.join("release") end
		def self.max_pic_size; 1*1024*1024 end
	end
end
