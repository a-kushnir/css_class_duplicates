# frozen_string_literal: true

require "English"

module CssClassDuplicates
  class Scanner
    NEW_LINE = /(\r\n|\r|\n)/.freeze

    def initialize(content)
      @content = content
    end

    def scan(regex)
      @content.scan(regex).map do |match|
        position = $LAST_MATCH_INFO.offset(0)[0]
        line = file_line(position)
        [match.compact.first, line]
      end
    end

    private

    def file_line(position)
      file_lines.index { |line_length| (position -= line_length) <= 0 } + 1
    end

    def file_lines
      @file_lines ||= @content.split(NEW_LINE).map(&:length).each_slice(2).map(&:sum)
    end
  end
end
