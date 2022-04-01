# frozen_string_literal: true

require_relative 'lib/css_class_duplicates/version'

Gem::Specification.new do |spec|
  spec.name    = 'css_class_duplicates'
  spec.version = CssClassDuplicates::VERSION
  spec.authors = ['Andrew Kushnir']
  spec.email   = ['akushnir2009@gmail.com']

  spec.summary = 'CSS class duplication search tool.'
  spec.description = <<-DESCRIPTION
    The gem searches for CSS class set duplicates, so they can be replaced with something meaningful,
    like "border border-gray-400 bg-gray-100 mt-1 ..." can be replaced with "widget".
    Supports Tailwind CSS and its alternatives
  DESCRIPTION
  spec.homepage = 'https://github.com/a-kushnir/css_class_duplicates'
  spec.license = 'MIT'
  spec.platform = Gem::Platform::RUBY
  spec.required_ruby_version = '>= 2.5.0'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/a-kushnir/css_class_duplicates'
  spec.metadata['bug_tracker_uri'] = 'https://github.com/a-kushnir/css_class_duplicates/issues'

  spec.files = Dir.glob('{assets,config,lib}/**/*', File::FNM_DOTMATCH)
  spec.bindir = 'exe'
  spec.executables = ['css_class_duplicates']
end
