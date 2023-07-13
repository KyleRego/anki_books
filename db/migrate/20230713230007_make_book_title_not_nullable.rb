# frozen_string_literal: true

class MakeBookTitleNotNullable < ActiveRecord::Migration[7.0]
  def change
    change_column_null :books, :title, false
  end
end
