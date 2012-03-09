require "spec_helper"

Process = Pajama::Process

describe Process do
	describe ".find" do
		it "works" do
			lambda{ Process.find("not_exist_process") }.should raise_error(Pajama::Error)
			lambda{ Process.find("underwear") }.should_not raise_error(Pajama::Error)
		end
	end

  describe ".run" do
    before :each do
      @oldpwd = Pa.pwd; Pa.mkdir(Rc.p.project); Pa.cd(Rc.p.project)
      Pa.mkdir *%w[new release]
      Pa.touch *%w[new/src.a.jpg new/tao.a.jpg new/a.jpg]
    end

    after :each do
      Pa.cd @oldpwd
      Pa.rm_r "#{Rc.p.project}"
    end

    it "works" do
      Process.stub_chain("find.process")
      Process.stub(:find){ x=double; x.should_receive(:process).with(Pa("#{$spec_data}/gooten/new/a.jpg")); x }

      Process.run("pajama")

      Pa("release/a.jpg").should be_exists
    end
  end
end
