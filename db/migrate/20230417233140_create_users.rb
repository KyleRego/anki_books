# frozen_string_literal: true

##
# This users table is temporary - after I have a mail server,
# I intend to drop this table and set up users in a robust way with Devise.
# For now, this is to allow myself access to editing articles.
class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :username
      t.string :password_digest

      t.timestamps
    end
  end
end
