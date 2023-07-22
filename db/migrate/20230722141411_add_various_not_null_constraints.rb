# frozen_string_literal: true

class AddVariousNotNullConstraints < ActiveRecord::Migration[7.0]
  def change
    change_column_null :books_domains, :book_id, false
    change_column_null :books_domains, :domain_id, false
    change_column_null :domains, :user_id, false
  end
end
