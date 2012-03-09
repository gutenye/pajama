module Pajama
	class Picture
    class << self
      def handle(*args, &blk)
        Picture.new.handle *args, &blk
      end
    end

		def handle(dir_desc="new")
			path = Pa"#{Rc.p.project}/#{dir_desc}"

			o={}
			# "new"
			if dir_desc == "new"
				o = {new: true}
				Pa.each(path) {|pa|
					next unless pa.directory?
					type = pa.name
					Pa.each(pa) {|pa1|
						next unless pa1.directory?
						product_id = pa1.name
						handle_dir(pa1, type, product_id, o)
					}
				}

			# "pajama"
			elsif dir_desc.count('/') == 0
				type = dir_desc
				Pa.each(path) {|pa|
					next unless pa.directory?
					product_id = pa.name
					handle_dir(pa, type, product_id, o)
				}

			# "pajama/jyx113"
			elsif dir_desc.count('/') == 1
				_, type, product_id = dir_desc.match(/(.*)\/(.*)/).to_a
				handle_dir(path, type, product_id, o)
			end

			# empty new/
			if o[:new]
				Pa.rm_r "#{Rc.p.project}/new/*" unless $spec_test
			end

		end

		def handle_dir(dir, type, product_id, o={})
			processor = Process.find(type)
			paths = Pa.each(dir).with_object([]){|(pa), m| m << pa if Util.picture_file?(pa)}

			# write to release/
			processor.process(paths, type, product_id, o)

			# move to pajama/jyx1114
			if o[:new]
				Pa.mv_f dir, "#{Rc.p.project}/#{type}"
			end
		end
	end
end
