# frozen_string_literal: true

class AddBooksForeignKeyToBooksUsers < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :books_users, :books
  end
end
