require "json"

module Sylvia
  class CLI
    FILE_NAME = "sylvia.rb"
    PRETTIER_FILE = ".prettierrc"
    PACKAGE_FILE = "package.json"

    def self.start(args)
      command = args.shift

      case command
      when "llm"
        setup_llm
      when "ai"
        run_llm
      when "prettier"
        setup_prettier
      else
        puts "Usage:"
        puts "  sylvia llm   # Create setup file llm"
        puts "  sylvia ai    # Run llm"
        puts "  sylvia prettier  # Setup Prettier for Ruby"
      end
    end

    def self.setup_llm
      content = <<~RUBY
        require 'ruby_llm'
        require 'tty-markdown'
        require 'dotenv'
        Dotenv.load

        RubyLLM.configure do |config|
          config.gemini_api_key = ENV.fetch('gemini', nil)
        end

        chat = RubyLLM.chat(model: 'gemini-2.0-flash')

        response = chat.ask "how to improve this code", with: ["assets/example.rb", "assets/example2.rb"]

        markdown = response.content.to_s
        
        puts TTY::Markdown.parse(markdown)
      RUBY

      File.write(FILE_NAME, content)
      puts "✅ Created #{FILE_NAME}"
    end

    def self.run_llm
      unless File.exist?(FILE_NAME)
        puts "⚠️  #{FILE_NAME} not found. Run `sylvia install` first."
        return
      end

      system("ruby #{FILE_NAME}")
    end

    def self.setup_prettier
      if File.exist?(PRETTIER_FILE)
        puts "⚠️  #{PRETTIER_FILE} already exists. Skipping."
        return
      end

      prettier_config = <<~JSON
    {
      "plugins": ["@prettier/plugin-ruby"],
      "rubyStrictMode": false,
      "tabWidth": 2,
      "useTabs": false,
      "singleQuote": true
    }
  JSON

      File.write(PRETTIER_FILE, prettier_config)
      puts "✅ Created #{PRETTIER_FILE}"

      unless File.exist?(PACKAGE_FILE)
        puts "⚡ Running `npm init -y`..."
        system("npm init -y")
      end

      package_json = JSON.parse(File.read(PACKAGE_FILE))
      package_json["devDependencies"] ||= {}
      package_json["devDependencies"]["prettier"] = "^3.5.3"
      package_json["devDependencies"]["@prettier/plugin-ruby"] = "^4.0.4"
      File.write(PACKAGE_FILE, JSON.pretty_generate(package_json))
      puts "✅ Updated #{PACKAGE_FILE} devDependencies"

      puts "⚡ Running `npm install`..."
      system("npm install")

      gemfile = "Gemfile"
      if File.exist?(gemfile)
        content = File.read(gemfile)
        unless content.include?('gem "syntax_tree"')
          File.open(gemfile, "a") { |f| f.puts "\ngem \"syntax_tree\"" }
          puts "✅ Added gem 'syntax_tree' to Gemfile"
        else
          puts "⚠️  Gemfile already contains syntax_tree"
        end

        puts "⚡ Running `bundle install`..."
        system("bundle install")
      else
        puts "⚠️  No Gemfile found. Skipping syntax_tree installation."
      end

      puts "🎉 Prettier setup complete!"
    end
  end
end
