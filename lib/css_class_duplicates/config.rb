# frozen_string_literal: true

require 'yaml'
require 'rake/file_list'

module CssClassDuplicates
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
