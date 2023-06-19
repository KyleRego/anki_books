# frozen_string_literal: true

class AddUsersForeignKeyToBooksUsers < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :books_users, :users
  end
end
