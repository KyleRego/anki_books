# frozen_string_literal: true

class RenameNewActiveStorageAttachmentsUuidsForeignKeys < ActiveRecord::Migration[7.0]
  def change
    rename_column :active_storage_attachments, :tmp_record_id, :record_id
    rename_column :active_storage_attachments, :tmp_blob_id, :blob_id
  end
end
