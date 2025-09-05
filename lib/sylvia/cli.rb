require "json"
require_relative "llm"
require_relative "prettier"
require_relative "rubocop"

module Sylvia
  class CLI
    def self.start(args)
      command = args.shift

      case command
      when "llm"
        LLM.setup
      when "ai"
        LLM.run
      when "prettier"
        Prettier.setup
      when "rubocop"
        RuboCop.setup
      when "rubocop-todo"
        RuboCop.generate_todo
      else
        puts "Usage:"
        puts "  sylvia llm           # Create setup file llm"
        puts "  sylvia ai            # Run llm"
        puts "  sylvia prettier      # Setup Prettier for Ruby"
        puts "  sylvia rubocop       # Create .rubocop.yml config file"
        puts "  sylvia rubocop-todo  # Generate .rubocop_todo.yml automatically"
      end
    end
  end
end
