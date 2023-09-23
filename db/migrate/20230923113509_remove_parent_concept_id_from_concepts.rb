# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

class RemoveParentConceptIdFromConcepts < ActiveRecord::Migration[7.0]
  def change
    remove_column :concepts, :parent_concept_id
  end
end
