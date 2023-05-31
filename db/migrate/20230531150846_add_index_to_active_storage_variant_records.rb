# frozen_string_literal: true

class AddIndexToActiveStorageVariantRecords < ActiveRecord::Migration[7.0]
  def change
    add_index :active_storage_variant_records, [:blob_id, :variation_digest], unique: true, name: "index_active_storage_variant_records_uniqueness"
  end
end
