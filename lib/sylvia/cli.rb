module Sylvia
  class CLI
    def self.start(args)
      command = args.shift

      case command
      when "install"
        create_file
      else
        puts "Usage: sylvia install"
      end
    end

    def self.create_file
      filename = "example.txt"
      File.write(filename, "Hello from sylvia!\n")
      puts "✅ Created #{filename}"
    end
  end
end
