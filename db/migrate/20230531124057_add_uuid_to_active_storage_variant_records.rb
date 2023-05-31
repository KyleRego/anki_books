# frozen_string_literal: true

class AddUuidToActiveStorageVariantRecords < ActiveRecord::Migration[7.0]
  def change
    add_column :active_storage_variant_records, :tmp_id, :uuid, default: "gen_random_uuid()"
  end
end
