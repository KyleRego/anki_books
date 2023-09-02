# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

class CreateArticlesConceptsJoinTable < ActiveRecord::Migration[7.0]
  def change
    create_table :articles_concepts do |t|
      t.uuid :article_id
      t.uuid :concept_id

      t.timestamps

      t.index [:concept_id, :article_id], unique: true
    end
  end
end
