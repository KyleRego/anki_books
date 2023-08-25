# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

module OrdinalPositions
  module Validator
    # :nodoc:
    class BookArticles < Base
      private

      def ordinal_positions
        parent.articles.order(:ordinal_position).pluck(:ordinal_position)
      end

      def expected_ordinal_positions
        (0...parent.articles_count).to_a
      end
    end
  end
end
