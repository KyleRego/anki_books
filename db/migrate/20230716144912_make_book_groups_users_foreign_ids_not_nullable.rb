# frozen_string_literal: true

class MakeBookGroupsUsersForeignIdsNotNullable < ActiveRecord::Migration[7.0]
  def change
    change_column_null :book_groups_users, :book_group_id, false
    change_column_null :book_groups_users, :user_id, false
  end
end
