# frozen_string_literal: true

class AddIndexToBooksUsers < ActiveRecord::Migration[7.0]
  def change
    add_index :books_users, [:book_id, :user_id], unique: true
  end
end
