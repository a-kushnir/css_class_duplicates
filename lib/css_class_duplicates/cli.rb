# frozen_string_literal: true

module CssClassDuplicates
  # The CLI is a class responsible of handling all the command line interface logic.
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
        entities.concat(config.parser.call(file_name))
      end

      entities = config.merger.call(entities)
      entities = config.filter.call(entities)
      config.printer.call(entities)

      STATUS_SUCCESS
    rescue StandardError, SyntaxError, LoadError => e
      warn e.message
      warn e.backtrace
      STATUS_ERROR
    end
  end
end
