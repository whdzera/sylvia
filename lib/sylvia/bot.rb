require 'fileutils'

module Sylvia
  class Bot
    def self.new_project(target = 'bot-app')
      repo = 'https://github.com/spellbooks/ruby-discord-telegram-bot-boilerplate'

      if git_installed?
        puts '➡️  Git found, cloning repo...'
        system("git clone #{repo} #{target}")
      else
        puts '⚠️  Git not found, using fallback template...'
        copy_fallback_template(target)
      end

      puts "✅ Bot project created successfully in folder: #{target}"
    end

    private

    def self.git_installed?
      system('git --version > /dev/null 2>&1')
    end

    def self.copy_fallback_template(target)
      source = File.expand_path('../../templates/bot', __dir__)
      FileUtils.cp_r("#{source}/.", target)
    end
  end
end
