# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

# == Schema Information
#
# Table name: books
#
#  id             :uuid             not null, primary key
#  title          :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  parent_book_id :uuid
#
# Foreign Keys
#
#  fk_rails_...  (parent_book_id => books.id)
#
FactoryBot.define do
  factory :book do
    title { "Book title" }
    users { [] }
  end
end
