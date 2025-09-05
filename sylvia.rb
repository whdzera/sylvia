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
