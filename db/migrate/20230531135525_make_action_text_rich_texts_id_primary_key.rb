# frozen_string_literal: true

class MakeActionTextRichTextsIdPrimaryKey < ActiveRecord::Migration[7.0]
  def change
    execute <<-SQL
      ALTER TABLE action_text_rich_texts ADD PRIMARY KEY (id);
    SQL
  end
end
