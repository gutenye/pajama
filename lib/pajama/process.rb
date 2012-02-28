module Pajama
	class Process
    class << self
      @@processors = []

      def processors
        @@processors
      end

      def find(name)
        p = processors.find {|klass| klass.name=~/#{name}/i}

        unless p
          raise Error, "can't find the processor name -- #{name}" 
        end

        p
      end

      def run(type)
        files = Pa.each_r(Rc.p.new).with_object([]) {|(p), m|
          next if p.directory? 
          next if p.name =~ /^src\.|^tao\./

          m << p
        }

        Process.find(type).process(*files)

        Pa.mv_f "#{Rc.p.new}/*", "#{Rc.p.release}"
      end
    end
  end
end

%w[base pajama pajap underwear].each{|v| require "pajama/process/#{v}"}

# vim: fdn=4
