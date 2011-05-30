
module Pajama
	class CLI < Thor

		desc "mv", "mv camera to new"
		def mv
			unless Util.mounted?
				puts "ERROR. the camera is not mounted."
			end
			Picture.mv_pic 
		end

		desc "erp", "process erp"
		def erp
			Picture.process :erp
		end

	end
end
