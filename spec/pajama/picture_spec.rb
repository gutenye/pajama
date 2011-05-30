require "spec_helper"

include Pajama

describe Picture do
	describe ".mv_pic" do 

		def camera_setup
			Pa.cp_f Rc.mount_point.join("archive/a.JPG"), Rc.mount_point.join("a.JPG")
		end

		def clean_up
			pwd_bak = Pa.pwd
			Pa.cd $spec_dir.join('data')
			%w(camera/* pic/erp/* pic/new/* tmp_pic/*).each do |path|
				Pa.rm_f path
			end
			Pa.cd pwd_bak
		end

		it "works" do
			clean_up
			camera_setup
			Picture.mv_pic

			Rc.mount_point.join('a.JPG').should_not be_exists
			Rc.pic_dir.join("new/a.JPG").should be_exists
		end
	end

	describe ".process" do
		it "works" do
			Picture.process :erp

			Rc.tmp_dir.join('a.JPG').should be_exists
			Rc.pic_dir.join('new/a.JPG').should_not be_exists
			Rc.pic_dir.join('erp/a.JPG').should be_exists
		end
	end
end
