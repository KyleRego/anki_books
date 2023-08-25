# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

# == Schema Information
#
# Table name: books_users
#
#  id         :uuid             not null, primary key
#  user_id    :uuid             not null
#  book_id    :uuid             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (book_id => books.id)
#  fk_rails_...  (user_id => users.id)
#
class BooksUser < ApplicationRecord
  belongs_to :user
  belongs_to :book
end
