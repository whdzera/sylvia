module Sylvia
  class LLM
    FILE_NAME = 'sylvia.rb'
    GITIGNORE_FILE = '.gitignore'

    def self.setup
      content = <<~RUBY
        require 'ruby_llm'
        require 'tty-markdown'

        api_key = 'xxx'
        model_ai = 'gemini-2.0-flash'

        RubyLLM.configure do |config|
          config.gemini_api_key = api_key
        end

        chat = RubyLLM.chat(model: model_ai)

        response = chat.ask <<~PROMPT, with: ["assets/example.rb", "assets/example2.rb"]
  Please review the following Ruby code and suggest improvements:

  1. Use descriptive variable names.
  2. Follow Ruby style conventions.
  3. Optimize loops and iterators.
  4. Avoid unnecessary complexity.
PROMPT

        markdown = response.content.to_s

        puts TTY::Markdown.parse(markdown)
      RUBY

      File.write(FILE_NAME, content)
      puts "Created #{FILE_NAME}"

      if File.exist?(GITIGNORE_FILE)
        gitignore_content = File.read(GITIGNORE_FILE).split("\n")
        if gitignore_content.include?(FILE_NAME)
          puts "#{FILE_NAME} is already in #{GITIGNORE_FILE}"
        else
          File.open(GITIGNORE_FILE, 'a') { |f| f.puts FILE_NAME }
          puts "Added #{FILE_NAME} to #{GITIGNORE_FILE}"
        end
      else
        File.write(GITIGNORE_FILE, "#{FILE_NAME}\n")
        puts "Created #{GITIGNORE_FILE} and added #{FILE_NAME}"
      end
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
