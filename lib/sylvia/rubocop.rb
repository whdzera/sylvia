module Sylvia
  class RuboCop
    CONFIG_FILE = '.rubocop.yml'

    def self.setup
      if File.exist?(CONFIG_FILE)
        puts "#{CONFIG_FILE} already exists. Skipping."
        return
      end

      config_content = <<~YAML
        AllCops:
          Include:
            - "**/*.rb"
            - "**/*.rake"
            - "."
          Exclude:
            - "vendor/**/*"
            - "db/schema.rb"
          NewCops: enable

        Layout/LineLength:
          Max: 120
          Exclude:
            - "spec/**/*"

        Style/BlockDelimiters:
          Exclude:
            - "spec/**/*"

        Lint/AmbiguousBlockAssociation:
          Exclude:
            - "spec/**/*"

        Metrics/BlockLength:
          Exclude:
            - "spec/**/*"

        Layout/HeredocIndentation:
          Enabled: false

        Metrics/ClassLength:
          Max: 175

        Metrics/MethodLength:
          Max: 25

        Metrics/ParameterLists:
          Max: 20

        Metrics/AbcSize:
          Enabled: false

        Metrics/PerceivedComplexity:
          Enabled: false

        Metrics/CyclomaticComplexity:
          Enabled: false

        Style/HashEachMethods:
          Enabled: true

        Style/HashTransformKeys:
          Enabled: false

        Style/HashTransformValues:
          Enabled: false
      YAML

      File.write(CONFIG_FILE, config_content)
      puts "Created #{CONFIG_FILE}"
    end

    def self.generate_todo
      todo_file = '.rubocop_todo.yml'

      if File.exist?(todo_file)
        puts "#{todo_file} already exists. Skipping generation."
        return
      end

      puts 'Generating RuboCop TODO...'
      system('rubocop --auto-gen-config --no-exclude-limit')
      puts "RuboCop TODO generated (see #{todo_file})"
    end
  end
end
