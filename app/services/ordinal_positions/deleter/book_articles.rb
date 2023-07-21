# frozen_string_literal: true

module OrdinalPositions
  module Deleter
    # :nodoc:
    class BookArticles < Base
      private

      def parent
        @parent ||= child_to_delete.book
      end

      def other_ordinal_position_children
        parent.ordered_articles
      end

      def shift_other_ordinal_children
        other_ordinal_position_children.where("ordinal_position > ?", original_ordinal_position)
                                       .each do |article_to_shift|
          article_to_shift.update!(ordinal_position: article_to_shift.ordinal_position - 1)
        end
      end

      def ordinal_positions_valid?
        ::OrdinalPositions::Validator::BookArticles.perform(parent:)
      end
    end
  end
end
