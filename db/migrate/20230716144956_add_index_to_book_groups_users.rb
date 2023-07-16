# frozen_string_literal: true

class AddIndexToBookGroupsUsers < ActiveRecord::Migration[7.0]
  def change
    add_index :book_groups_users, [:book_group_id, :user_id], unique: true
  end
end
