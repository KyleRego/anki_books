# frozen_string_literal: true

class DropBookGroupsBooks < ActiveRecord::Migration[7.0]
  def change
    drop_table :book_groups_books
  end
end
