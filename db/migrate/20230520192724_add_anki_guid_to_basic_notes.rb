# frozen_string_literal: true

class AddAnkiGuidToBasicNotes < ActiveRecord::Migration[7.0]
  def change
    add_column :basic_notes, :anki_guid, :string
  end
end
