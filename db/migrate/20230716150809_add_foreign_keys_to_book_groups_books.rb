# frozen_string_literal: true

class AddForeignKeysToBookGroupsBooks < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :book_groups_books, :books
    add_foreign_key :book_groups_books, :book_groups
  end
end
