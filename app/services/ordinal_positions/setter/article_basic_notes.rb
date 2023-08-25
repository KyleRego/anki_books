# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

module OrdinalPositions
  module Setter
    # :nodoc:
    class ArticleBasicNotes < Base
      private

      def child_belongs_to_parent?
        child_to_position.new_record? || parent.basic_notes.include?(child_to_position)
      end

      def ordinal_position_children_count
        @ordinal_position_children_count ||= child_to_position.new_record? ? parent.notes_count + 1 : parent.notes_count
      end

      def other_ordinal_position_children
        parent.basic_notes
      end

      def ordinal_positions_valid?
        ::OrdinalPositions::Validator::ArticleBasicNotes.perform(parent:)
      end
    end
  end
end
