# frozen_string_literal: true

module OrdinalPositions
  module Setter
    ##
    # See OrdinalPositions::Setter:ArticleBasicNotes
    class BookArticles < Base
      private

      def ordinal_position_children_count
        @ordinal_position_children_count ||= child_to_position.new_record? ? parent.articles_count + 1 : parent.articles_count
      end

      def other_ordinal_position_children
        parent.articles
      end

      def ordinal_positions_valid?
        ::OrdinalPositions::Validator::BookArticles.perform(parent:)
      end
    end
  end
end
