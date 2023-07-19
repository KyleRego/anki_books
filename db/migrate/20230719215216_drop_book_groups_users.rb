# frozen_string_literal: true

class DropBookGroupsUsers < ActiveRecord::Migration[7.0]
  def change
    drop_table :book_groups_users
  end
end
