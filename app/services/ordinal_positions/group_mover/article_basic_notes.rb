# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

module OrdinalPositions
  module GroupMover
    # :nodoc:
    class ArticleBasicNotes < Base
      private

      def valid_move_target?
        new_parent.book_id == old_parent.book_id
      end

      def all_children_to_position_belong_to_old_article?
        article_ids = children_to_position.pluck(:article_id).uniq
        article_ids.count == 1 && article_ids.first == old_parent.id
      end

      def move_children_to_position_to_new_parent
        children_to_position.order(:ordinal_position).each do |basic_note|
          basic_note.update(article: new_parent, ordinal_position: new_parent.basic_notes_count)
        end
      end

      def shift_old_parent_children
        old_parent.ordered_basic_notes.each_with_index do |basic_note, index|
          # TODO: See about doing this with one SQL statement
          basic_note.update(ordinal_position: index)
        end
      end

      def ordinal_positions_valid?
        ::OrdinalPositions::Validator::ArticleBasicNotes.perform(parent: new_parent)
        ::OrdinalPositions::Validator::ArticleBasicNotes.perform(parent: old_parent)
      end
    end
  end
end
