# frozen_string_literal: true

module OrdinalPositions
  # :nodoc:
  class MoveChildToNewParent
    ##
    # Moves an ordinally positioned child +child_to_position+
    # to a new parent +parent+ at the specified ordinal position +new_ordinal_position+
    # keeping both parents ordinal position children consistent
    def self.perform(new_parent:, child_to_position:, new_ordinal_position:)
      if new_parent.instance_of?(Article) && child_to_position.instance_of?(BasicNote)
        OrdinalPositions::Mover::ArticleBasicNotes.perform(new_parent:, child_to_position:, new_ordinal_position:)
      elsif new_parent.instance_of?(Book) && child_to_position.instance_of?(Article)
        OrdinalPositions::Mover::BookArticles.perform(new_parent:, child_to_position:, new_ordinal_position:)
      else
        raise "OrdinalPositions::AddChildAtPosition was called with invalid arguments."
      end
    end
  end
end
