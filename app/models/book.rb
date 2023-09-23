# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

# == Schema Information
#
# Table name: books
#
#  id         :uuid             not null, primary key
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Book < ApplicationRecord
  include Book::HasManyOrdinalChildren

  validates :title, presence: true

  has_many :books_users, dependent: :destroy
  has_many :users, through: :books_users

  has_many :books_domains, dependent: :destroy
  has_many :domains, through: :books_domains

  has_many :articles, dependent: :destroy

  scope :ordered, -> { order(:title) }

  delegate :count, to: :articles, prefix: true

  def ordered_basic_notes
    BasicNote.joins(article: :book)
             .where(articles: { book_id: id })
             .order("articles.ordinal_position, basic_notes.ordinal_position")
  end
end
