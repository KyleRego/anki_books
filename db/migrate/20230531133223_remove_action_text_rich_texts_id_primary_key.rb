# frozen_string_literal: true

class RemoveActionTextRichTextsIdPrimaryKey < ActiveRecord::Migration[7.0]
  def change
    remove_column :action_text_rich_texts, :id, :bigint, primary_key: true
  end
end
