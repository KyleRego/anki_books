# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# == Schema Information
#
# Table name: books_concepts
#
#  id         :uuid             not null, primary key
#  book_id    :uuid             not null
#  concept_id :uuid             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

# frozen_string_literal: true

##
# Join table between books and concepts
class BooksConcept < ApplicationRecord
  belongs_to :book
  belongs_to :concept
end
