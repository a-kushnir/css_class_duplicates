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
      @ignore = to_regex_array(classes&.dig('ignore'))
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
      classes = classes.reject { |value| include?(@ignore, value) }
      return [] if @include.any? && classes.none? { |value| include?(@include, value) }
      return [] if @exclude.any? && classes.any? { |value| include?(@exclude, value) }

      classes
    end

    def include?(list, value)
      list.detect { |regex| value =~ regex }
    end

    def to_regex_array(array)
      array&.map { |pattern| Globber.for(pattern) } || []
    end
  end
end
