# frozen_string_literal: true

module CssClassDuplicates
  class Finder
    MATCHER = /
      \s+class\s*=\s*["']?([\w\s\-_:]+)["']?|       # class = "hello world"
      class:\s*["']?([\w\s\-_:]+)["']?|             # class: 'hello world'
      ["']?class["']?\s=>\s*["']?([\w\s\-_:]+)["']? # 'class' => "hello world"
    /x.freeze
    WHITESPACE = /\s/.freeze

    def self.call(file_name)
      content = File.read(file_name)

      matches = Scanner.new(content).scan(MATCHER)
      matches.map do |match, line|
        classes = match.split(WHITESPACE).reject(&:empty?)
        next if classes.empty?

        Match.new(classes.map(&:downcase).sort, ["#{file_name}:#{line}"])
      end.compact
    end
  end
end
