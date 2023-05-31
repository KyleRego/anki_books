# frozen_string_literal: true

class AddUuidToActiveStorageBlobs < ActiveRecord::Migration[7.0]
  def change
    add_column :active_storage_blobs, :tmp_id, :uuid, default: "gen_random_uuid()"
  end
end
