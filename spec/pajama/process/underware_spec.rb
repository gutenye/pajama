require "spec_helper"
require "pajama/process"

Underware = Process::Underware

xdescribe UnderwearProcess do
	before :each do
		Pa.rm_r $spec_dir.join("data/pic")
		Pa.cp $spec_dir.join("data/data_pic"), $spec_dir.join("data/pic")
	end

	after :each do
	end

	it "works" do
		path = $spec_dir.join("data/underwear.jpg")
		watermark_pa = $spec_dir.join("data/watermark.png")

		processor = UnderwearProcess.new(path, "underwear", "jyx1113", watermark_pa)

		# resize
		processor.resize "750x"

		# watermark
		processor.watermark

		#processor.img.display
	end

	describe ".process_all" do
		it "works" do
			files = Pa.each($spec_dir.join("data/pic/underwear/jz13")).with_object([]){|pa,m|m<<pa}
			type, product_id = "underwear", "jz13"
			Pa.mkdir_f(Rc.release_pa.join(type, product_id))
			UnderwearProcess.process_all(files, type, product_id)
			#`gpicview #{$spec_dir.join("data/pic/release/underwear/jz13/all.jpg")}`
		end
	end
end


# zong watermark
xdescribe Underware do
	it "works" do
		path = $spec_dir.join("data/underwear.jpg")
		watermark_pa = $spec_dir.join("data/watermark_zong_26.png")

		processor = UnderwearProcess.new(path, "underwear", "jyx1113", watermark_pa)

		# resize
		processor.resize "750x"

		# watermark
		processor.watermark_zong

		#processor.img.display
	end
end

