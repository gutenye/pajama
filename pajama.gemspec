$: << "."
require "version"

Gem::Specification.new do |s|
	s.name = "pajama"
	s.version = Pajama::VERSION::IS
	s.summary = "a good lib"
	s.description = <<-EOF
a good lib
	EOF

	s.author = "Guten"
	s.email = "ywzhaifei@Gmail.com"
	s.homepage = "http://github.com/GutenLinux/pajama"
	s.rubyforge_project = "xx"

	s.files = `git ls-files`.split("\n")

	s.add_dependency "tagen"
	s.add_dependency "thor"

	s.executables = %w(pajama)
end
