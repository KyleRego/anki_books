# frozen_string_literal: true

module OrdinalPositions
  class SetChildPosition
    def self.perform(parent:, child_to_position:, new_ordinal_position:)
      if parent.instance_of?(Article) && child_to_position.instance_of?(BasicNote)
        OrdinalPositions::Setter::ArticleBasicNotes.perform(parent:, child_to_position:, new_ordinal_position:)
      elsif parent.instance_of?(Book) && child_to_position.instance_of?(Article)
        OrdinalPositions::Setter::BookArticles.perform(parent:, child_to_position:, new_ordinal_position:)
      else
        raise "OrdinalPositions::SetChildPosition was called with invalid arguments."
      end
    end
  end
end
