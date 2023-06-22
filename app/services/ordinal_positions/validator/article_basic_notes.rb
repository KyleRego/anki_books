# frozen_string_literal: true

module OrdinalPositions
  module Validator
    # :nodoc:
    class ArticleBasicNotes < Base
      private

      def ordinal_positions
        parent.notes.pluck(:ordinal_position)
      end

      def expected_ordinal_positions
        (0...parent.notes_count).to_a
      end
    end
  end
end
