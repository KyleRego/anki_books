# frozen_string_literal: true

class MakeArticlesTitleNotNullable < ActiveRecord::Migration[7.0]
  def change
    change_column_null :articles, :title, false
  end
end
