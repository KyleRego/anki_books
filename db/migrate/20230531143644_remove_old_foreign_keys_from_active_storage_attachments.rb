# frozen_string_literal: true

class RemoveOldForeignKeysFromActiveStorageAttachments < ActiveRecord::Migration[7.0]
  def change
    remove_column :active_storage_attachments, :record_id, :bigint
    remove_column :active_storage_attachments, :blob_id, :bigint
  end
end
