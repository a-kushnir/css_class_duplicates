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

      config = Config.new
      config.files.each do |file_name|
        entities.concat(Finder.call(file_name))
      end

      entities = Merger.call(entities)
      entities = Filter.call(entities)
      Printer.call(entities)

      STATUS_SUCCESS
    rescue StandardError, SyntaxError, LoadError => e
      warn e.message
      warn e.backtrace
      STATUS_ERROR
    end
  end
end
