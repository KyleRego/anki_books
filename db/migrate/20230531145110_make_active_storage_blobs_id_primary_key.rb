# frozen_string_literal: true

class MakeActiveStorageBlobsIdPrimaryKey < ActiveRecord::Migration[7.0]
  def change
    execute <<-SQL
      ALTER TABLE active_storage_blobs ADD PRIMARY KEY (id);
    SQL
  end
end
