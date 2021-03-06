# frozen_string_literal: true

require_relative 'css_class_duplicates/cli'
require_relative 'css_class_duplicates/config'
require_relative 'css_class_duplicates/filter'
require_relative 'css_class_duplicates/globber'
require_relative 'css_class_duplicates/match'
require_relative 'css_class_duplicates/merger'
require_relative 'css_class_duplicates/parser'
require_relative 'css_class_duplicates/printer'
require_relative 'css_class_duplicates/scanner'
require_relative 'css_class_duplicates/version'

module CssClassDuplicates
  class Error < StandardError; end
end
