# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

class AddConstraintsThatOrdinalPositionsMustBeNonNegative < ActiveRecord::Migration[7.0]
  def change
    execute "ALTER TABLE articles ADD CHECK (ordinal_position >= 0);"
    execute "ALTER TABLE basic_notes ADD CHECK (ordinal_position >= 0);"
  end
end
