# frozen_string_literal: true

class MakeActiveStorageAttachmentsForeignKeyIdsNotNullable < ActiveRecord::Migration[7.0]
  def change
    change_column_null :active_storage_attachments, :record_id, false
    change_column_null :active_storage_attachments, :blob_id, false
  end
end
