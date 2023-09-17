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

  has_many :books_concepts, dependent: :destroy
  has_many :concepts, through: :books_concepts

  has_many :books_users, dependent: :destroy
  has_many :users, through: :books_users

  has_many :books_domains, dependent: :destroy
  has_many :domains, through: :books_domains

  has_many :articles, dependent: :destroy
  has_many :ordered_articles, -> { order(:ordinal_position) }, class_name: "Article", inverse_of: :book, dependent: :destroy

  validates :title, presence: true

  # rubocop:disable Rails/Delegate
  def articles_count
    articles.count
  end
  # rubocop:enable Rails/Delegate

  def ordered_concepts
    concepts.order(:name)
  end

  def ordered_domains
    domains.order(:title)
  end

  def ordered_basic_notes
    BasicNote.joins(article: :book)
             .where(articles: { book_id: id })
             .order("articles.ordinal_position, basic_notes.ordinal_position")
  end
end
