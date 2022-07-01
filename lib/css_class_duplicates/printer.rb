# frozen_string_literal: true

module CssClassDuplicates
  # This class renders the result in console.
  class Printer
    def call(entities)
      entities.sort_by { |entity| [-entity.files.size, -entity.classes.size] }.each do |entity|
        puts "#{entity.files.size} matches for \"#{entity.classes.join(' ')}\""
        entity.files.uniq.sort.each do |file_name|
          puts "  #{file_name}"
        end
        puts
      end
    end
  end
end
