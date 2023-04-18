# frozen_string_literal: true

class AddUniqueConstraintsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_index :users, :username, unique: true
    add_index :users, :email, unique: true
  end
end
