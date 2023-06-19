# frozen_string_literal: true

class MakeArticlesOrdinalPositionNotNullable < ActiveRecord::Migration[7.0]
  def change
    change_column_null :articles, :ordinal_position, false
  end
end
