require "spec_helper"

include Pajama
describe PajapProcess do
	it "works ok" do
		process = PajapProcess.new(Pa($spec_dir).join("data/a.jpg"))
		img = process.process
		img.display
	end
end


