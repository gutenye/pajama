module Pajama
  class Process
    class Underwear < Base
      class << self
        def process(files, o={})
          Underware.process_1200x files, o
          Underware.process_30x30 files, o
          Underware.process_all files, o
        end

        # only for 00.jpg 10.jpg detail1.jpg
        def process_1200x(files, o={})
          files.find_all { |pa|
            %w[00 10 detail1].include? pa.name
          }.each { |pa|
            Underware.ui.say "process 1200x: #{pa}"
            process = Underware.new(pa)
            process.process_1200x
          }
        end

        # all front 10.jpg 20.jpg ..
        def process_30x30(files, o={})
          # 10.jpg -> 30x30
          files.find_all { |pa|
            pa.name =~ /^[1-9]0$/
          }.each { |pa|
            Underware.ui.say "process 30x30: #{pa}"
            process = Underware.new(pa, o)
            process.process_30x30
          }
        end

        def process_all(files, o={})
          #
          # all.jpg -> 750x
          #
          rst_h = files.group_by { |pa| 
            if pa.name =~ /^[0-1].$/
              0
            elsif pa.name =~ /^detail/
              1
            else
              2
            end
          }
          rst = rst_h.each.with_object([]){|(k,v),m| m << v.sort}.flatten
          images = []
          rst.each { |pa|
            Underware.ui.say "process 750x: #{pa}"
            process = Underware.new(pa, o)
            images << process.process_750x
          }

          # append all images into one image
          img = Magick::ImageList.new
          images.each {|image|
            img << image
          }
          img = img.append(true)

          Underware.ui.say "generate all: #{pa}"
          img.write("#{files[0].d2}/tao.all.jpg") do |img| 
            img.quality = 70
          end
        end
      end

      def process_1200x
        resize "1200x"
        do_watermark *Rc.o.watermark
        write "#{file.name}_1200x.#{file.ext}"
      end

      def process_30x30
        thumbnail "30x30"
        write "#{file.name}_30x30.#{file.ext}"
      end

      def process_750x
        resize "750x"
        do_watermark *Rc.o.watermark
        #compress 70
      end
    end
  end
end

# vim: fdn=5
