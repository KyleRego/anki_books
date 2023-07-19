# frozen_string_literal: true

class AddUserIdToDomains < ActiveRecord::Migration[7.0]
  def change
    add_column :domains, :user_id, :uuid
  end
end
