# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

class AddDefaultValuesForArticlesWritingReadingComplete < ActiveRecord::Migration[7.0]
  def change
    change_column_default :articles, :reading, true
    change_column_default :articles, :writing, false
    change_column_default :articles, :complete, false
  end
end
