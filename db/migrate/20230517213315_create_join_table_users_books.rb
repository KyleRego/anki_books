# frozen_string_literal: true

class CreateJoinTableUsersBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books_users, id: :uuid do |t|
      t.bigint :user_id
      t.uuid :book_id

      t.timestamps
    end
  end
end
