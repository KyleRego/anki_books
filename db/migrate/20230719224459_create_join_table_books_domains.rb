# frozen_string_literal: true

class CreateJoinTableBooksDomains < ActiveRecord::Migration[7.0]
  def change
    create_table :books_domains, id: :uuid do |t|
      t.uuid :book_id
      t.uuid :domain_id

      t.timestamps
    end
  end
end
