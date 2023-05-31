# frozen_string_literal: true

class RemoveActiveStorageAttachmentsPrimaryKeyId < ActiveRecord::Migration[7.0]
  def change
    remove_column :active_storage_attachments, :id, :bigint, primary_key: true
  end
end
