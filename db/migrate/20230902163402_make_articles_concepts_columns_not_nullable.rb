# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

class MakeArticlesConceptsColumnsNotNullable < ActiveRecord::Migration[7.0]
  def change
    change_column_null :articles_concepts, :article_id, false
    change_column_null :articles_concepts, :concept_id, false
  end
end
