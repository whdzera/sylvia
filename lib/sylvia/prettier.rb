require 'json'

module Sylvia
  class Prettier
    PRETTIER_FILE = '.prettierrc'
    PACKAGE_FILE  = 'package.json'

    def self.setup
      if File.exist?(PRETTIER_FILE)
        puts "#{PRETTIER_FILE} already exists. Skipping."
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
      puts "Created #{PRETTIER_FILE}"

      unless File.exist?(PACKAGE_FILE)
        puts 'Running `npm init -y`...'
        system('npm init -y')
      end

      package_json = JSON.parse(File.read(PACKAGE_FILE))
      package_json['devDependencies'] ||= {}
      package_json['devDependencies']['prettier'] = '^3.5.3'
      package_json['devDependencies']['@prettier/plugin-ruby'] = '^4.0.4'
      File.write(PACKAGE_FILE, JSON.pretty_generate(package_json))
      puts "Updated #{PACKAGE_FILE} devDependencies"

      puts 'Running `npm install`...'
      system('npm install')

      gemfile = 'Gemfile'
      if File.exist?(gemfile)
        content = File.read(gemfile)
        if content.include?('gem "syntax_tree"')
          puts 'Gemfile already contains syntax_tree'
        else
          File.open(gemfile, 'a') { |f| f.puts "\ngem \"syntax_tree\"" }
          puts "Added gem 'syntax_tree' to Gemfile"
        end

        puts 'Running `bundle install`...'
        system('bundle install')
      else
        puts 'No Gemfile found. Skipping syntax_tree installation.'
      end

      puts 'Prettier setup complete!'
    end
  end
end
