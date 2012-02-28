require "spec_helper"

PajamaProcess = Pajama::Process

describe PajamaProcess do
	it "works ok" do
		process = PajamaProcess.new(Pa("#{$spec_dir}/data/pajama.jpg"))
		process.process "dir"

		img = process.instance_variable_get(:@src)
		puts "#{img.columns}x#{img.rows}"
		img.display
	end
end

