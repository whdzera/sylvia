module Sylvia
  class LLM
    FILE_NAME = 'sylvia.rb'

    def self.setup
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
      puts "Created #{FILE_NAME}"
    end

    def self.run
      unless File.exist?(FILE_NAME)
        puts "#{FILE_NAME} not found. Run `sylvia llm` first."
        return
      end

      system("ruby #{FILE_NAME}")
    end
  end
end
