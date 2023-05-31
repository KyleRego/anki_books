# frozen_string_literal: true

class RemoveActiveStorageBlobsIdPrimaryKey < ActiveRecord::Migration[7.0]
  def change
    remove_column :active_storage_blobs, :id, :bigint, primary_key: true
  end
end
