# frozen_string_literal: true

class AddUniqueOrdinalPositionBookIdIndexToArticles < ActiveRecord::Migration[7.0]
  def change
    add_index :articles, [:ordinal_position, :book_id], unique: true
  end
end
