# frozen_string_literal: true

module CssClassDuplicates
  # This class merges found results
  class Merger
    def initialize(config)
      @type = config['type']
    end

    def call(entities)
      matches = entities.group_by(&:classes).map do |classes, items|
        Match.new(classes, items.map(&:files).flatten)
      end
      matches = add_partial_matches(matches) if @type == 'partial'
      matches
    end

    private

    def add_partial_matches(matches)
      match_idx = matches.to_h { |match| [match.classes, match] }

      matches.combination(2) do |match1, match2|
        partial = match1.classes.intersection(match2.classes)
        next if partial.empty?

        existing = (match_idx[partial] ||= Match.new(partial, []))
        existing.files = (existing.files + match1.files + match2.files).uniq
      end

      match_idx.values
    end
  end
end
