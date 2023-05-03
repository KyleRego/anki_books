# frozen_string_literal: true

class ChangeOrdinalPositionToNotNullInBasicNotes < ActiveRecord::Migration[7.0]
  def up
    change_column :basic_notes, :ordinal_position, :integer, null: false
  end

  def down
    change_column :basic_notes, :ordinal_position, :integer, null: true
  end
end
