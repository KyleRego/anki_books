# frozen_string_literal: true

module OrdinalPositionsSetter
  ##
  # See OrdinalPositionsSetter:ArticleBasicNotes
  class BookArticles < Base
    private

    def ordinal_position_children_count
      @ordinal_position_children_count ||= child_to_position.new_record? ? parent.articles_count + 1 : parent.articles_count
    end

    def other_ordinal_position_children
      parent.articles
    end

    def ordinal_positions_valid?
      ::OrdinalPositionsValidator::BookArticles.perform(parent:)
    end
  end
end
