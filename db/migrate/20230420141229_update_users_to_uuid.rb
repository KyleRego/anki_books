# frozen_string_literal: true

class UpdateUsersToUuid < ActiveRecord::Migration[7.0]
  def up
    drop_table :users

    create_table :users, id: :uuid, default: "gen_random_uuid()" do |t|
      t.string :email
      t.string :username
      t.string :password_digest

      t.timestamps
    end
  end

  def down
    drop_table :users

    create_table :users do |t|
      t.string :email
      t.string :username
      t.string :password_digest

      t.timestamps
    end
  end
end
