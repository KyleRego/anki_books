# frozen_string_literal: true

class CreateBookGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :book_groups, id: :uuid, default: "gen_random_uuid()" do |t|
      t.string :title

      t.timestamps
    end
  end
end
