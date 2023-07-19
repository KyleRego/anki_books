# frozen_string_literal: true

class AddForeignKeysToBooksDomains < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :books_domains, :books
    add_foreign_key :books_domains, :domains
  end
end
