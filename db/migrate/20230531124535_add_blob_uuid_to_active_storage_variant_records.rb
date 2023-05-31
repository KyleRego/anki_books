# frozen_string_literal: true

class AddBlobUuidToActiveStorageVariantRecords < ActiveRecord::Migration[7.0]
  def change
    add_column :active_storage_variant_records, :tmp_blob_id, :uuid, null: true
  end
end
