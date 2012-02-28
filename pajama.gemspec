Kernel.load File.expand_path("../lib/pajama/version.rb", __FILE__)

Gem::Specification.new do |s|
	s.name = "pajama"
	s.version = Pajama::VERSION
	s.summary = "a util for process pajama related things"
	s.description = <<-EOF
a util for process pajama related things
	EOF

	s.author = "Guten"
	s.email = "ywzhaifei@Gmail.com"
	s.homepage = "http://github.com/GutenLinux/pajama"
	s.rubyforge_project = "xx"

	s.files = `git ls-files`.split("\n")
	s.executables = %w(pajama)

	#s.add_dependency 
end
