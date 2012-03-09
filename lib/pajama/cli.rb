require "thor"

module Pajama
	class CLI < Thor

    class_option "no-color", :banner => "Disable colorization in output", :type => :boolean
    class_option "verbose", :aliases => "-V", :banner => "Enable verbose output mode" :type => :boolean
		class_option "profile", :aliases => "-p", :default => "default", :banner => "load user profile", :type => :string

    attr_reader :o

    def initialize(*)
      super
      o = @o = options.dup
      the_shell = (options["no-color"] ? Thor::Shell::Basic.new : shell)
      Pajama.ui = UI::Shell.new(the_shell)
      Pajama.ui.debug! if options["verbose"]

      # load profile configuration
      Rc._merge! Optimima.require("~/.pajama/#{o[:profile]}")
			Rc.profile = o[:profile]
    end

		desc "process <type>", "process pic"
		def process(type)
      Process.run type
		end

    desc "archive", "mv release to archive"
    def archive(type)
      Pa.mv "#{Rc.p.release}/*", "#{Rc.p.archive}"
    end

		desc "mv", "mv camera to new"
		def mv
			unless Util.mounted?
				puts "ERROR. the camera is not mounted."
				exit
			end

      Pa.mv "#{Rc.p.mount_point}/*.JPG", "#{Rc.p.project}/new"
		end

		desc "clean", "clean up release directory"
		def clean
			Pa.rm_r "#{Rc.p.release}/*"
		end

		desc "origin", "cp new to original"
		def origin
			Pa.cp_f "#{Rc.p.project}/new/*",  "#{Rc.p.project}/original"
		end
	end
end
