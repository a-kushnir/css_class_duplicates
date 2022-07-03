# frozen_string_literal: true

module CssClassDuplicates
  # This class searches for CSS classes
  class Parser
    MATCHER = /
      \s+class\s*=\s*["']?([\w\s\-_:]+)["']?|       # class = "hello world"
      class:\s*["']?([\w\s\-_:]+)["']?|             # class: 'hello world'
      ["']?class["']?\s=>\s*["']?([\w\s\-_:]+)["']? # 'class' => "hello world"
    /x.freeze
    WHITESPACE = /\s/.freeze

    def initialize(config)
      classes = config.dig('classes')
      @include = to_regex_array(classes&.dig('include'))
      @exclude = to_regex_array(classes&.dig('exclude'))
      @delete = to_regex_array(classes&.dig('delete'))
    end

    def call(file_name)
      content = File.read(file_name)

      matches = Scanner.new(content).matches(MATCHER)
      matches.map do |match, line|
        classes = match.split(WHITESPACE).reject(&:empty?)
        next if classes.empty?

        classes = filter(classes.map(&:downcase).sort)
        next if classes.empty?

        Match.new(classes, ["#{file_name}:#{line}"])
      end.compact
    end

    private

    def filter(classes)
      return [] if @include.any? && !any?(@include, classes)
      return [] if @exclude.any? && any?(@exclude, classes)

      classes.reject { |value| include?(@delete, value) }
    end

    def any?(list, values)
      values.any? { |value| include?(list, value) } || include?(list, values.join(' '))
    end

    def include?(list, value)
      list.any? { |regex| value =~ regex }
    end

    def to_regex_array(array)
      array&.map { |pattern| Globber.for(pattern) } || []
    end
  end
end
