# frozen_string_literal: true

module CssClassDuplicates
  class Merger
    def self.call(entities)
      entities.group_by { |entity| entity.classes }.map do |classes, items|
        Match.new(classes, items.map(&:files).flatten)
      end
    end
  end
end
