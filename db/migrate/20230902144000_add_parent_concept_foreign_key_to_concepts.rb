# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

class AddParentConceptForeignKeyToConcepts < ActiveRecord::Migration[7.0]
  def up
    add_foreign_key :concepts, :concepts, column: :parent_concept_id, type: :uuid
  end
end
