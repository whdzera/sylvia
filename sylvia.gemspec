# frozen_string_literal: true

require_relative "lib/sylvia/version"

Gem::Specification.new do |spec|
  spec.name = "sylvia"
  spec.version = Sylvia::VERSION
  spec.authors = ["whdzera"]
  spec.email = ["whdzera@gmail.com"]

  spec.summary =
    "A command-line tool for generating and managing Ruby projects."
  spec.description =
    "Sylvia is a command-line tool that helps you create and manage Ruby projects with ease."
  spec.homepage = "https://github.com/whdzera/sylvia"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.1.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/whdzera/sylvia"
  spec.metadata["changelog_uri"] = "https://github.com/whdzera/sylvia"

  gemspec = File.basename(__FILE__)
  spec.files = `git ls-files -z`.split("\x0")
  spec.bindir = "bin"
  spec.executables = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "ruby_llm"
  spec.add_dependency "dotenv"
  spec.add_dependency "tty-markdown"
  spec.add_development_dependency "syntax_tree"
end
