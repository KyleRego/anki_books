# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

class UpdateBooksPublicToFalse < ActiveRecord::Migration[7.0]
  def up
    execute <<-SQL
      UPDATE books SET public = false;
    SQL
  end

  def down
    execute <<-SQL
      UPDATE books SET public = NULL;
    SQL
  end
end
