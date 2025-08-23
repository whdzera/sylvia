module Sylvia
  class CLI
    FILE_NAME = "sylvia.rb"

    def self.start(args)
      command = args.shift

      case command
      when "install"
        create_file
      when "run"
        run_file
      else
        puts "Usage:"
        puts "  sylvia install  # Create sylvia.rb"
        puts "  sylvia run      # Run sylvia.rb"
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
  end
end
