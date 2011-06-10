require "spec_helper"

$collections=[]
class Pajama::Picture
	def handle_dir dir, type, product_id, o={}
		$collections << [dir.absolute, type, product_id, o]
	end
end

include Pajama
describe Picture do
	describe ".handle" do
		# new/
		#   pajama/ jyx1112 jyx1113
		#   pajap/ jyx1111
		# pajama/ lz12 lz11

		before(:all) do
			%w(new/pajama/jyx1112 new/pajama/jyx1113 new/pajap/jyx1111
				 pajama/lz12 pajama/lz11).each do |name|
				Pa.mkdir Rc.pic_dir.join(name)
			 end
		end

		after(:all) do
			# empty new/ pajama/
			Pa.rm_r Rc.pic_dir.join("new/*")
			Pa.rm_r Rc.pic_dir.join("pajama/*")
		end

		it "handle new/" do
			right = [ 
				[Rc.pic_dir.join("new/pajama/jyx1112").absolute, "pajama", "jyx1112", {new: true}],
				[Rc.pic_dir.join("new/pajama/jyx1113").absolute, "pajama", "jyx1113", {new: true}],
				[Rc.pic_dir.join("new/pajap/jyx1111").absolute, "pajap", "jyx1111", {new: true}],
			]

			Picture.handle("new")
			$collections.sort{|a,b| a[0]<=>b[0]}.should == right
			$collections = []
		end

		it "handle pajama" do
			right = [
				[Rc.pic_dir.join("pajama/lz11").absolute, "pajama", "lz11", {}],
				[Rc.pic_dir.join("pajama/lz12").absolute, "pajama", "lz12", {}],
			]
			Picture.handle("pajama")
			$collections.sort{|a,b| a[0]<=>b[0]}.should == right
			$collections = []
		end

		it "handle pajama/lz11" do
			right = [
				[Rc.pic_dir.join("pajama/lz11").absolute, "pajama", "lz11", {}]
			]
			Picture.handle("pajama/lz11")
			$collections.sort{|a,b| a[0]<=>b[0]}.should == right
			$collections = []
		end
	end
end
