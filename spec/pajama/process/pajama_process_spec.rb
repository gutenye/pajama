require "spec_helper"

include Pajama
describe PajamaProcess do
	it "works ok" do
		process = PajamaProcess.new(Pa($spec_dir).join("data/pajama.jpg"))
		process.process 'dir'

		img = process.instance_variable_get(:@src)
		puts "#{img.columns}x#{img.rows}"
		img.display
	end
end

