require "pajama"

$spec_test = true
$spec_dir = Pa(Pa(__FILE__).dir)
module Pajama
	class Rc
		def self.mount_point; $spec_dir.join("data/camera") end
		def self.pic_dir; $spec_dir.join("data/pic") end
		def self.release_pa; $spec_dir.join("data/pic/release") end
		def self.watermark_pa; $spec_dir.join("data/watermark.png") end 
	end
end

