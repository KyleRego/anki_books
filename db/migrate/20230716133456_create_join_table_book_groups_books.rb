# frozen_string_literal: true

class CreateJoinTableBookGroupsBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :book_groups_books, id: :uuid do |t|
      t.uuid :book_id
      t.uuid :book_group_id

      t.timestamps
    end
  end
end
