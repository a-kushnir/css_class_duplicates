# frozen_string_literal: true

module CssClassDuplicates
  # This class filters found results to exclude CSS classes that aren't duplicated
  class Filter
    def initialize(config)
      @min_classes = config.dig('classes', 'min') || 1
      @min_matches = config.dig('matches', 'min') || 1
    end

    def call(entities)
      entities.select do |entity|
        entity.classes.size > @min_classes && entity.files.size > @min_matches
      end
    end
  end
end
