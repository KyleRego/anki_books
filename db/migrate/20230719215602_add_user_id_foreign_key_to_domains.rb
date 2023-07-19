# frozen_string_literal: true

class AddUserIdForeignKeyToDomains < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :domains, :users
  end
end
