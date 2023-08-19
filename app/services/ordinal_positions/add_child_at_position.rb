# frozen_string_literal: true

module OrdinalPositions
  # :nodoc:
  class AddChildAtPosition
    ##
    # Managing changing the ordinal position of a child in a one-to-many
    # association where the child objects on the many side have an ordinal position.
    # +child_to_position+ can be an unpersisted child and inserted into the children
    # or it can be moved from one position to another and the other children are shifted.
    #
    # This is used for basic notes which belong to an article and have ordinal positions,
    # and articles which belong to a book in the same way.
    #
    # +parent+ and +child_to_position+ can be a book and article or an article and basic note.
    # The +new_ordinal_position+ can be 0 up to the number of children minus one.
    def self.perform(parent:, child_to_position:, new_ordinal_position:)
      if parent.instance_of?(Article) && child_to_position.instance_of?(BasicNote)
        OrdinalPositions::Setter::ArticleBasicNotes.perform(parent:, child_to_position:, new_ordinal_position:)
      elsif parent.instance_of?(Book) && child_to_position.instance_of?(Article)
        OrdinalPositions::Setter::BookArticles.perform(parent:, child_to_position:, new_ordinal_position:)
      else
        raise "OrdinalPositions::AddChildAtPosition was called with invalid arguments."
      end
    end
  end
end
