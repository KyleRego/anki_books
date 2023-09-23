# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

class AddArticlesConceptsForeignKeys < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :articles_concepts, :concepts, column: :concept_id, type: :uuid
    add_foreign_key :articles_concepts, :articles, column: :article_id, type: :uuid
  end
end
