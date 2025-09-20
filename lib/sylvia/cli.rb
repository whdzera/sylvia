# lib/sylvia/cli.rb
require "json"
require_relative "version"
require_relative "llm"
require_relative "prettier"
require_relative "rubocop"
require_relative "jekyll"
require_relative "bot"

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
      when "jekyll"
        target = args.shift || "jekyll-app"
        Jekyll.new_project(target)
      when "bot"
        target = args.shift || "bot-app"
        Bot.new_project(target)
      when "-v", "--version"
        puts "Sylvia version #{Sylvia::VERSION}"
      else
        puts "Usage:"
        puts "  sylvia llm           # Create setup file llm"
        puts "  sylvia ai            # Run llm"
        puts "  sylvia prettier      # Setup Prettier for Ruby"
        puts "  sylvia rubocop       # Create .rubocop.yml config file"
        puts "  sylvia rubocop-todo  # Generate .rubocop_todo.yml automatically"
        puts "  sylvia jekyll [name-app]  # Create Jekyll boilerplate project"
        puts "  sylvia bot [name-app]     # Create Discord & Telegram bot boilerplate project"
        puts "  sylvia -v, --version # Show Sylvia version"
      end
    end
  end
end
