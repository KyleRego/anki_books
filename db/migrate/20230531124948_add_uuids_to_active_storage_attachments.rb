# frozen_string_literal: true

class AddUuidsToActiveStorageAttachments < ActiveRecord::Migration[7.0]
  def change
    add_column :active_storage_attachments, :tmp_record_id, :uuid, null: true
    add_column :active_storage_attachments, :tmp_blob_id, :uuid, null: true
  end
end
