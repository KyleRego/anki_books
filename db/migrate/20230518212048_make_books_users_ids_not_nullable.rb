class MakeBooksUsersIdsNotNullable < ActiveRecord::Migration[7.0]
  def change
    change_column_null :books_users, :book_id, false
    change_column_null :books_users, :user_id, false
  end
end
