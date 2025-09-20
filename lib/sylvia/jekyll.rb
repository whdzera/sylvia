# lib/sylvia/jekyll.rb
require 'fileutils'

module Sylvia
  class Jekyll
    def self.new_project(target = 'jekyll-app')
      repo = 'https://github.com/spellbooks/jekyll-boilerplate'

      if git_installed?
        puts 'Git found, cloning repo...'
        system("git clone #{repo} #{target}")
      else
        puts 'Git not found, using fallback template...'
        copy_fallback_template(target)
      end

      puts "Project created successfully in folder: #{target}"
    end

    private

    def self.git_installed?
      system('git --version > /dev/null 2>&1')
    end

    def self.copy_fallback_template(target)
      source = File.expand_path('../../templates/jekyll', __dir__)
      FileUtils.cp_r("#{source}/.", target)
    end
  end
end
