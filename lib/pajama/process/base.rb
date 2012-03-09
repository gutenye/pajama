require "tagen/RMagick"

module Pajama
  class Process
    class Base
      def self.inherited(klass)
        Process.processors << klass
      end

      attr_reader :file, :options, :watermark, :image

      def initialize(file, o={})
        @image = Magick::ImageList.new(file.p)[0]
        @file = file
        @watermark = Magick::ImageList.new(Rc.p.watermark)[0] 
        @options = o
      end

    private

      # resize("1200x")
      def resize(geometry)
        @image = image.change_geometry(geometry) { |cols, rows, img|
          img.resize(cols, rows)
        }
      end

      # thumbnail("30x30")
      def thumbnail(geometry)
        @image = image.change_geometry(geometry) { |cols, rows, img|
          img.thumbnail(cols, rows)
        }
      end

      # do_watermark(0.8, "Center", 0, 100)
      #   src with * 80%
      #   put watermark at south end +0+100
      def do_watermark(resize, gravity, x, y)
        # fit watermark to src width * 80%
        @watermark = watermark.change_geometry "#{image.columns*resize}" do |cols,rows,img|
          img.resize(cols,rows)
        end

        # put watermark at south end +0+100
        @image = image.composite(watermark, Magick.const_get("#{gravity}Gravity"), x, y, Magick::OverCompositeOp)
      end

      # compress(70)
      def compress(quality)
        return if file.name =~ /^_/
        @image = Magick::Image.from_blob(image.to_blob{|i| i.quality=quality})[0]
      end

      def write(fname=nil)
        fname ||= @file.fname

        image.write("#{file.d2}/#{fname}") do |img| 
          img.quality = 70 unless fname =~ /^_/
        end

        image
      end
    end
  end
end
