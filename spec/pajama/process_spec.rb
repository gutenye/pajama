require "spec_helper"

include Pajama

describe Pajama::Process do
	describe ".find" do
		it "works" do
			lambda{Pajama::Process.find("not_exist_process")}.should raise_error(Error)
			lambda{Pajama::Process.find("taobao")}.should_not raise_error(Error)
		end
	end
end
