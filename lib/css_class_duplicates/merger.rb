# frozen_string_literal: true

module CssClassDuplicates
  # This class merges found results
  class Merger
    def self.call(entities)
      entities.group_by(&:classes).map do |classes, items|
        Match.new(classes, items.map(&:files).flatten)
      end
    end
  end
end
