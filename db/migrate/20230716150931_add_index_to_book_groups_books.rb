# frozen_string_literal: true

class AddIndexToBookGroupsBooks < ActiveRecord::Migration[7.0]
  def change
    add_index :book_groups_books, [:book_group_id, :book_id], unique: true
  end
end
