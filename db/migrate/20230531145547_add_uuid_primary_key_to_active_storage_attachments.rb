# frozen_string_literal: true

class AddUuidPrimaryKeyToActiveStorageAttachments < ActiveRecord::Migration[7.0]
  def change
    add_column :active_storage_attachments, :id, :uuid, default: "gen_random_uuid()", primary_key: true
  end
end
