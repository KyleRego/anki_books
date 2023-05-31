# frozen_string_literal: true

class RemoveBlobIdIndexFromActiveStorageAttachments < ActiveRecord::Migration[7.0]
  def change
    remove_index :active_storage_attachments, name: :index_active_storage_attachments_on_blob_id
  end
end
