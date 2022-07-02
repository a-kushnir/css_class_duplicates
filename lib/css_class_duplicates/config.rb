# frozen_string_literal: true

require 'yaml'
require 'rake/file_list'

module CssClassDuplicates
  # This class represents the configuration of the gem.
  # A Config is associated with a YAML configuration
  # file from which it was read.
  class Config
    PROJECT_CONFIG = '.css_class_duplicates.yml'
    DEFAULT_CONFIG = File.expand_path('../../config/default.yml', __dir__)

    def initialize
      filename = File.exist?(PROJECT_CONFIG) ? PROJECT_CONFIG : DEFAULT_CONFIG
      @config = YAML.load_file(filename)
    end

    def files
      Rake::FileList.new.tap do |file_list|
        if (files = @config['files'])
          if (include = files['include'])
            file_list.include(include)
          end
          if (exclude = files['exclude'])
            file_list.exclude(exclude)
          end
        else
          file_list.include('**/*')
        end
      end
    end

    def parser
      @parser ||= Parser.new(@config['filters'])
    end

    def merger
      @merger ||= Merger.new(@config['matches'])
    end

    def filter
      @filter ||= Filter.new(@config['filters'])
    end

    def printer
      @printer ||= Printer.new
    end
  end
end
