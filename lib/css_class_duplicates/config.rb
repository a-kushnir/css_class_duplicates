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
      @config = YAML.load_file(filename, symbolize_names: true)
    end

    def files
      files = @config[:files]
      Rake::FileList.new.tap do |file_list|
        file_list.include(files[:include])
        file_list.exclude(files[:exclude])
      end
    end
  end
end
