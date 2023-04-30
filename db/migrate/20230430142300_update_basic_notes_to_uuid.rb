# frozen_string_literal: true

class UpdateBasicNotesToUuid < ActiveRecord::Migration[7.0]
  def up
    drop_table :basic_notes

    create_table :basic_notes, id: :uuid, default: "gen_random_uuid()" do |t|
      t.text :front
      t.text :back
      t.bigint :anki_id

      t.timestamps
    end

    add_column :basic_notes, :article_id, :uuid, null: false
    add_foreign_key :basic_notes, :articles, column: :article_id, type: :uuid
  end

  def down
    drop_table :basic_notes

    create_table :basic_notes do |t|
      t.text :front
      t.text :back
      t.bigint :anki_id

      t.timestamps
    end

    add_column :basic_notes, :article_id, :uuid, null: false
    add_foreign_key :basic_notes, :articles, column: :article_id, type: :uuid
  end
end
