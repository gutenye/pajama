module Pajama
	class Util

		def self.mounted?
			Pa.exists? "/dev/camera"
		end

		def self.picture_file? file
			Pa.extname(file) =~ /jpg|png|gif/i
		end

	end
end
