# frozen_string_literal: true

require_relative "lib/sylvia/version"

Gem::Specification.new do |spec|
  spec.name = "sylvia"
  spec.version = Sylvia::VERSION
  spec.authors = ["whdzera"]
  spec.email = ["whdzera@gmail.com"]

  spec.summary = "A command-line tool for generating and managing Ruby projects."
  spec.description = "Sylvia is a command-line tool that helps you create and manage Ruby projects with ease."
  spec.homepage = "https://github.com/whdzera/sylvia"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.1.0"

  spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/whdzera/sylvia"
  spec.metadata["changelog_uri"] = "https://github.com/whdzera/sylvia"

  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
