# frozen_string_literal: true

class CreateJoinTableBookGroupsUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :book_groups_users, id: :uuid do |t|
      t.uuid :user_id
      t.uuid :book_group_id

      t.timestamps
    end
  end
end
