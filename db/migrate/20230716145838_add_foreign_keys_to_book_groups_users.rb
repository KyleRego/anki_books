# frozen_string_literal: true

class AddForeignKeysToBookGroupsUsers < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :book_groups_users, :users
    add_foreign_key :book_groups_users, :book_groups
  end
end
