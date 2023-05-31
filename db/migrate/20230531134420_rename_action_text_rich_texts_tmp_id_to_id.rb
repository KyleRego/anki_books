# frozen_string_literal

class RenameActionTextRichTextsTmpIdToId < ActiveRecord::Migration[7.0]
  def change
    rename_column :action_text_rich_texts, :tmp_id, :id
  end
end
