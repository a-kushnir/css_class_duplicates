# frozen_string_literal: true

module CssClassDuplicates
  class Application
    attr_reader :args

    def initialize(args)
      @args = args
    end

    def execute
      entities = []

      Dir.glob("**/*.html.erb") do |file_name|
        entities.concat(Finder.(file_name))
      end

      entities = Merger.(entities)
      entities = Filter.(entities)
      Printer.(entities)

      exit 0
    end
  end
end
