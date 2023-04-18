class AddSystemToArticles < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :system, :boolean, default: false, null: false
  end
end
