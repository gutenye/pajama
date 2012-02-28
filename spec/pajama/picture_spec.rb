require "spec_helper"

$collections=[]
class Pajama::Picture
  def handle_dir(dir, type, product_id, o={})
    $collections << [dir.absolute2, type, product_id, o]
  end
end

Picture = Pajama::Picture

describe Picture do
	describe ".handle" do
		# new/
		#   pajama/ jyx1112 jyx1113
		#   pajap/ jyx1111
		# pajama/ lz12 lz11

		before(:all) do
			%w(new/pajama/jyx1112 new/pajama/jyx1113 new/pajap/jyx1111
				 pajama/lz12 pajama/lz11).each do |name|
				Pa.mkdir "#{Rc.p.pic}/#{name}"
			 end
		end

		after(:all) do
			# empty new/ pajama/
			Pa.rm_r "#{Rc.p.pic}/new/*"
			Pa.rm_r "#{Rc.p.pic}/pajama/*"
		end

		it "handle new/" do
			right = [ 
				[Pa.absolute2("#{Rc.p.pic}/new/pajama/jyx1112"), "pajama", "jyx1112", {new: true}],
				[Pa.absolute2("#{Rc.p.pic}/new/pajama/jyx1113"), "pajama", "jyx1113", {new: true}],
				[Pa.absolute2("#{Rc.p.pic}/new/pajap/jyx1111"), "pajap", "jyx1111", {new: true}],
			]

			Picture.handle("new")
			$collections.sort{|a,b| a[0]<=>b[0]}.should == right
			$collections = []
		end

		it "handle pajama" do
			right = [
				[Pa.absolute2("#{Rc.p.pic}/pajama/lz11"), "pajama", "lz11", {}],
				[Pa.absolute2("#{Rc.p.pic}/pajama/lz12"), "pajama", "lz12", {}],
			]
			Picture.handle("pajama")
			$collections.sort{|a,b| a[0]<=>b[0]}.should == right
			$collections = []
		end

		it "handle pajama/lz11" do
			right = [
				[Pa.absolute2("#{Rc.p.pic}/pajama/lz11"), "pajama", "lz11", {}]
			]
			Picture.handle("pajama/lz11")
			$collections.sort{|a,b| a[0]<=>b[0]}.should == right
			$collections = []
		end
	end
end
