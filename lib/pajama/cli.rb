module Pajama
	class CLI < Thor

		desc "mv", "mv camera to new"
		def mv
			unless Util.mounted?
				puts "ERROR. the camera is not mounted."
			end
			Picture.mv_pic 
		end

		# dir: new taobao pajap taobao/jyx111 pajap/jyx111
		#
		desc "pic [dir] ", "process pic"
		method_options :p => :string # profile
		def pic dir="new"
			profile = options[:p] ? options[:p] : "default"
			Picture.load_profile(profile)
			Picture.handle profile, dir
		end

		desc "clean", "clean tmp dir"
		def clean
			Pa.rm_r Rc.tmp_dir.join("*")
		end

	end
end
