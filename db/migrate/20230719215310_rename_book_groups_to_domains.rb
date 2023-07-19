# frozen_string_literal: true

class RenameBookGroupsToDomains < ActiveRecord::Migration[7.0]
  def change
    rename_table :book_groups, :domains
  end
end
