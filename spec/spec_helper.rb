require "pajama"

$spec_dir = Pa(Pa(__FILE__).dir)
module Pajama
	class Rc
		def self.mount_point; $spec_dir.join("data/camera") end
		def self.pic_dir; $spec_dir.join("data/pic") end
		def self.tmp_dir; $spec_dir.join("data/tmp_pic") end
	end
end



