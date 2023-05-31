# frozen_string_literal: true

class MakeBlobIdsForeignKeys < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
    add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  end
end
