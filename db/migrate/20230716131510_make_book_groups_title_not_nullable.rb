# frozen_string_literal: true

class MakeBookGroupsTitleNotNullable < ActiveRecord::Migration[7.0]
  def change
    change_column_null :book_groups, :title, false
  end
end
