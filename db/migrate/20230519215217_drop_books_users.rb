# frozen_string_literal: true

class DropBooksUsers < ActiveRecord::Migration[7.0]
  def change
    drop_join_table :books, :users
  end
end
