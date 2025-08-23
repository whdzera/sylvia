require 'json'

module Sylvia



  
  
  class CLI
    FILE_NAME = "sylvia.rb"
    PRETTIER_FILE = ".prettierrc"
    PACKAGE_FILE = "package.json"

    def self.start(args)
      command = args.shift

      case command
      when "install"
        create_file
      when "run"
        run_file
      when "prettier"
        setup_prettier
      else
        puts "Usage:"
        puts "  sylvia install   # Create sylvia.rb"
        puts "  sylvia run       # Run sylvia.rb"
        puts "  sylvia prettier  # Setup Prettier for Ruby"
      end
    end

    def self.create_file
      content = <<~RUBY
        require 'ruby_llm'
        require 'dotenv'
        Dotenv.load

        RubyLLM.configure do |config|
          config.gemini_api_key = ENV.fetch('gemini', nil)
        end

        chat = RubyLLM.chat(model: 'gemini-2.0-flash')

        # Just ask questions
        response = chat.ask "Siapa prabowo Subianto?"
        puts response.content
      RUBY

      File.write(FILE_NAME, content)
      puts "✅ Created #{FILE_NAME}"
    end

    def self.run_file
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
      puts "🎉 Prettier setup complete!"
    end
  end
end
