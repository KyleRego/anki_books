# frozen_string_literal: true

class CreateBasicNotes < ActiveRecord::Migration[7.0]
  def change
    create_table :basic_notes do |t|
      t.text :front
      t.text :back
      t.bigint :anki_id

      t.timestamps
    end
  end
end
