$: << "."
require "version"

Gem::Specification.new do |s|
	s.name = "pajama"
	s.version = Pajama::VERSION::IS
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
