# frozen_string_literal: true

class AddBookIdToArticles < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :book_id, :uuid, null: true
    add_foreign_key :articles, :books, column: :book_id, type: :uuid
  end
end
