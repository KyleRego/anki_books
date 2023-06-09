# frozen_string_literal: true

class AddUniquenessIndexToBasicNotesAnkiGuid < ActiveRecord::Migration[7.0]
  def change
    add_index :basic_notes, :anki_guid, unique: true
  end
end
