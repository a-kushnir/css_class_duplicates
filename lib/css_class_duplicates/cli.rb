# frozen_string_literal: true

module CssClassDuplicates
  class CLI
    STATUS_SUCCESS = 0
    STATUS_ERROR = 0

    def initialize
      @options = {}
    end

    def run
      entities = []

      Dir.glob("**/*.html.erb") do |file_name|
        entities.concat(Finder.(file_name))
      end

      entities = Merger.(entities)
      entities = Filter.(entities)
      Printer.(entities)

      STATUS_SUCCESS

    rescue StandardError, SyntaxError, LoadError => e
      warn e.message
      warn e.backtrace
      STATUS_ERROR
    end
  end
end
