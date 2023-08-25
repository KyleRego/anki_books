# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

# == Schema Information
#
# Table name: books_domains
#
#  id         :uuid             not null, primary key
#  book_id    :uuid             not null
#  domain_id  :uuid             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (book_id => books.id)
#  fk_rails_...  (domain_id => domains.id)
#
class BooksDomain < ApplicationRecord
  belongs_to :domain
  belongs_to :book
end
