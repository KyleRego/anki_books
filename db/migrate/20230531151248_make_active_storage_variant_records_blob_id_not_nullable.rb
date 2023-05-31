# frozen_string_literal: true

class MakeActiveStorageVariantRecordsBlobIdNotNullable < ActiveRecord::Migration[7.0]
  def change
    change_column_null :active_storage_variant_records, :blob_id, false
  end
end
