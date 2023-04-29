# frozen_string_literal: true

class AddArticleIdToBasicNotes < ActiveRecord::Migration[7.0]
  def change
    add_column :basic_notes, :article_id, :uuid, null: false
    add_foreign_key :basic_notes, :articles, column: :article_id, type: :uuid
  end
end
