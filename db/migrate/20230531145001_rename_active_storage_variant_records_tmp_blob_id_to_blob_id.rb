# frozen_string_literal: true

class RenameActiveStorageVariantRecordsTmpBlobIdToBlobId < ActiveRecord::Migration[7.0]
  def change
    rename_column :active_storage_variant_records, :tmp_blob_id, :blob_id
  end
end
