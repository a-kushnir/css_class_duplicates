# frozen_string_literal: true

module CssClassDuplicates
  class Finder
    MATCHER = %r{
      class\s*\=\s*["']?([\w\s\-_:]+)["']?|          # class = "hello world"
      class\:\s*["']?([\w\s\-_:]+)["']?|             # class: 'hello world'
      ["']?class["']?\s=>\s*["']?([\w\s\-_:]+)["']?  # 'class' => "hello world"
    }x.freeze
    WHITESPACE = %r{\s}.freeze

    def self.call(file_name)
      content = File.read(file_name)
      matches = content.scan(MATCHER).map(&:compact).flatten

      matches.map do |match|
        classes = match.split(WHITESPACE).reject(&:empty?)
        next if classes.empty?

        Match.new(classes.map(&:downcase).sort, [file_name])
      end.compact
    end
  end
end
