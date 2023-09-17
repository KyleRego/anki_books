# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

module OrdinalPositions
  module Mover
    # :nodoc:
    class BookArticles < Base
      private

      def old_parent
        @old_parent ||= @child_to_position.book
      end

      def move_child_to_position_to_new_parent
        child_to_position.update(book: new_parent, ordinal_position: new_parent.articles_count)
        new_parent.reposition_child(child: child_to_position, new_ordinal_position:)
      end

      def shift_old_parent_children
        old_parent.articles.order(:ordinal_position).where("ordinal_position > ?", old_ordinal_position).each do |article|
          article.update!(ordinal_position: article.ordinal_position - 1)
        end
      end

      def ordinal_positions_valid?
        ::OrdinalPositions::Validator::BookArticles.perform(parent: new_parent)
        ::OrdinalPositions::Validator::BookArticles.perform(parent: old_parent)
      end
    end
  end
end
