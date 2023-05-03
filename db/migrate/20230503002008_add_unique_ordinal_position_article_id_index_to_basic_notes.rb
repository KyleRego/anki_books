# frozen_string_literal: true

class AddUniqueOrdinalPositionArticleIdIndexToBasicNotes < ActiveRecord::Migration[7.0]
  def change
    add_index :basic_notes, [:ordinal_position, :article_id], unique: true
  end
end
