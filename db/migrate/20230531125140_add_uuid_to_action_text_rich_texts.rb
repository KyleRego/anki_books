# frozen_string_literal: true

class AddUuidToActionTextRichTexts < ActiveRecord::Migration[7.0]
  def change
    add_column :action_text_rich_texts, :tmp_id, :uuid, default: "gen_random_uuid()"
  end
end
