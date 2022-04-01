# frozen_string_literal: true

module CssClassDuplicates
  # This class filters found results to exclude CSS classes that aren't duplicated
  class Filter
    def self.call(entities)
      entities.select do |entity|
        entity.classes.size > 1 && entity.files.size > 1
      end
    end
  end
end
