module Pajama
	class CLI < Thor

		class_options :p => :string # profile

		desc "mv", "mv camera to new"
		def mv
			load_config(options[:p] || "default")
			unless Util.mounted?
				puts "ERROR. the camera is not mounted."
				exit
			end
			Picture.mv_pic 
		end

		# dir: new taobao pajap taobao/jyx111 pajap/jyx111
		#
		desc "pic [dir] ", "process pic"
		def pic dir="new"
			load_config(options[:p] || "default")
			Picture.handle dir
		end

		desc "clean", "clean up release directory"
		def clean
			load_config(options[:p] || "default")
			Pa.rm_r Rc.p.release.join("*")
		end

		desc "origin", "cp new to original"
		def origin
			load_config(options[:p] || "default")
			Pa.cp_f Rc.p.pic.join("new/*"), Rc.p.pic.join("original")
		end

		private
		def load_config name
			Pajama.const_set :Rc, O.load("~/.pajama/#{name}")
			Rc.profile = name
		end

	end
end
