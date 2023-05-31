# frozen_string_literal: true

class RenameActiveStorageBlobsTmpIdToId < ActiveRecord::Migration[7.0]
  def change
    rename_column :active_storage_blobs, :tmp_id, :id
  end
end
