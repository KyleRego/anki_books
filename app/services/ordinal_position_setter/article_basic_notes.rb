# frozen_string_literal: true

module OrdinalPositionSetter
  ##
  # Manages inserting a new basic note at a specific ordinal position or
  # setting its new ordinal position; the other notes are shifted appropriately.
  # The methods here hook into the general logic like a template method.
  class ArticleBasicNotes < Base
    private

    def ordinal_position_children_count
      @ordinal_position_children_count ||= child_to_position.new_record? ? parent.notes_count + 1 : parent.notes_count
    end

    def other_ordinal_position_children
      parent.basic_notes
    end
  end
end
