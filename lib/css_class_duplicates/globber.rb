# frozen_string_literal: true

module CssClassDuplicates
  # The class compares strings using wildcard symbols
  class Globber
    def self.for(value)
      return value if value.is_a?(Regexp)

      escaped = Regexp.escape(value).gsub('\*', '.*?')
      Regexp.new("^#{escaped}$", Regexp::IGNORECASE)
    end
  end
end
