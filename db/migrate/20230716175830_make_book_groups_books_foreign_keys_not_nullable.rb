# frozen_string_literal: true

class MakeBookGroupsBooksForeignKeysNotNullable < ActiveRecord::Migration[7.0]
  def change
    change_column_null :book_groups_books, :book_group_id, false
    change_column_null :book_groups_books, :book_id, false
  end
end
