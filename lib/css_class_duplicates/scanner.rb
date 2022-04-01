# frozen_string_literal: true

require 'English'

module CssClassDuplicates
  # This class scans string and returns all found matches with positions
  class Scanner
    NEW_LINE = /(\r\n|\r|\n)/.freeze

    def initialize(content)
      @content = content
    end

    def matches(regex)
      matches_with_positions(regex).map do |match, start_position|
        [match, file_line(start_position)]
      end
    end

    private

    def matches_with_positions(regex)
      matches = []
      @content.scan(regex) do |captures|
        captures.each_with_index do |capture, index|
          next unless capture

          start_position, end_position = $LAST_MATCH_INFO.offset(index + 1)
          matches << [capture, start_position, end_position]
        end
      end
      matches
    end

    def file_line(position)
      file_lines.index { |line_length| (position -= line_length) <= 0 } + 1
    end

    def file_lines
      @file_lines ||= @content.split(NEW_LINE).map(&:length).each_slice(2).map(&:sum)
    end
  end
end
