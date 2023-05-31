# frozen_string_literal: true

class AddIndexesToActiveStorageAttachments < ActiveRecord::Migration[7.0]
  def change
    add_index :active_storage_attachments, :blob_id, name: "index_active_storage_attachments_on_blob_id"
    add_index :active_storage_attachments, [:record_type, :record_id, :name, :blob_id], name: "index_active_storage_attachments_uniqueness", unique: true
  end
end
