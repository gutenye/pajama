module Pajama
	class Util
		def self.mounted?
			Pa.exists? "/dev/camera"
		end
	end
end
