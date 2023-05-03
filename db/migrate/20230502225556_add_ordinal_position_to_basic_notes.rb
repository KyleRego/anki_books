# frozen_string_literal: true

class AddOrdinalPositionToBasicNotes < ActiveRecord::Migration[7.0]
  def up
    add_column :basic_notes, :ordinal_position, :integer

    execute <<~SQL
      UPDATE basic_notes bn
      SET ordinal_position = (
        SELECT COUNT(*)
        FROM basic_notes
        WHERE article_id = bn.article_id AND anki_id <= bn.anki_id
      ) - 1
    SQL
  end

  def down
    remove_column :basic_notes, :ordinal_position
  end
end
