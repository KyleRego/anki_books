# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

module OrdinalPositions
  module Mover
    # :nodoc:
    class ArticleBasicNotes < Base
      private

      def old_parent
        @old_parent ||= @child_to_position.article
      end

      def move_child_to_position_to_new_parent
        child_to_position.update(article: new_parent, ordinal_position: new_parent.notes_count)
        ::OrdinalPositions::Setter::ArticleBasicNotes.perform(parent: new_parent, child_to_position:, new_ordinal_position:)
      end

      def shift_old_parent_children
        old_parent.basic_notes.order(:ordinal_position).where("ordinal_position > ?", old_ordinal_position).each do |basic_note|
          basic_note.update!(ordinal_position: basic_note.ordinal_position - 1)
        end
      end

      def ordinal_positions_valid?
        ::OrdinalPositions::Validator::ArticleBasicNotes.perform(parent: new_parent)
        ::OrdinalPositions::Validator::ArticleBasicNotes.perform(parent: old_parent)
      end
    end
  end
end
