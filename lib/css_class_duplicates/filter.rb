# frozen_string_literal: true

module CssClassDuplicates
  class Filter
    def self.call(entities)
      entities.select do |entity|
        entity.classes.size > 1 && entity.files.size > 1
      end
    end
  end
end
