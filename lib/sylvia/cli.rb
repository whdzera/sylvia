def self.create_file
  filename = "sylvia.rb"
  content = <<~RUBY
    require 'ruby_llm'
    require 'dotenv'
    Dotenv.load

    RubyLLM.configure do |config|
      config.gemini_api_key = ENV.fetch('gemini', nil)
    end

    chat = RubyLLM.chat(model: 'gemini-2.0-flash')

    response = chat.ask "Siapa prabowo Subianto?"
    puts response
  RUBY

  File.write(filename, content)
  puts "✅ Created #{filename}"
end