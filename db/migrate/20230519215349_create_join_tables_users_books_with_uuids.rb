class CreateJoinTablesUsersBooksWithUuids < ActiveRecord::Migration[7.0]
  def change
    create_table :books_users, id: :uuid do |t|
      t.uuid :user_id
      t.uuid :book_id

      t.timestamps
    end
  end
end
