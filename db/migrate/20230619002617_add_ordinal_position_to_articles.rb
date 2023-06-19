# frozen_string_literal: true

class AddOrdinalPositionToArticles < ActiveRecord::Migration[7.0]
  def up
    add_column :articles, :ordinal_position, :integer
  end

  def down
    remove_column :articles, :ordinal_position
  end
end
