# frozen_string_literal: true

class MakeBasicNotesAnkiGuidNotNullable < ActiveRecord::Migration[7.0]
  def change
    change_column_null :basic_notes, :anki_guid, false
  end
end
