# frozen_string_literal: true

module OrdinalPositions
  module Setter
    # :nodoc:
    class BookArticles < Base
      private

      def child_belongs_to_parent?
        child_to_position.new_record? || parent.articles.include?(child_to_position)
      end

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
