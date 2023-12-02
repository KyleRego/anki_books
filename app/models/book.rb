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
class Book < ApplicationRecord
  include Book::HasManyOrdinalChildren

  validates :title, presence: true
  validate :validate_parent_book

  ##
  # Validation that parent book is not set
  # to a book that is also a child, which would
  # create a cycle.
  # TODO: Complete implementation
  def validate_parent_book
    return if parent_book_id.nil?

    if parent_book_id == id
      errors.add :parent_book, "cannot be the same as the book"
      return
    end

    # TODO: This needs to check at a greater depth
    child_book_ids = books.pluck(:id)

    return unless child_book_ids.include?(parent_book_id)

    errors.add :parent_book, "cannot be one of the book's child books"
  end

  belongs_to :parent_book, optional: true, class_name: "Book", inverse_of: :books
  has_many :books, foreign_key: :parent_book_id, inverse_of: :parent_book, dependent: nil

  has_many :books_users, dependent: :destroy
  has_many :users, through: :books_users

  has_many :articles, dependent: :destroy
  has_many :basic_notes, through: :articles
  has_many :cloze_notes, through: :articles

  scope :ordered, -> { order(:title) }

  delegate :count, to: :articles, prefix: true

  def ordered_notes
    BasicNote.joins(article: :book)
             .where(articles: { book_id: id })
             .order("articles.ordinal_position, notes.ordinal_position")
  end

  def anki_deck_name
    if parent_book.nil?
      title
    else
      "#{parent_book.anki_deck_name}::#{title}"
    end
  end

  def anki_tag_name
    anki_deck_name.tr(" ", "_")
  end
end
