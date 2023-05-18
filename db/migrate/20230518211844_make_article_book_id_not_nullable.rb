# frozen_string_literal: true

class MakeArticleBookIdNotNullable < ActiveRecord::Migration[7.0]
  def change
    change_column_null :articles, :book_id, false
  end
end
