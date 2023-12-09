# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id              :uuid             not null, primary key
#  email           :string
#  username        :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
  has_secure_password

  has_many :concepts, dependent: :destroy

  has_many :books_users, dependent: :destroy
  has_many :books, -> { order(:title) }, through: :books_users
  has_many :articles, through: :books

  has_one_attached :anki_package

  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 12 }, on: :create

  ##
  # Returns user's concept with name +concept_name+ found by downcase comparison (or nil if not found)
  def find_existing_concept(concept_name:)
    concepts.where("lower(name) = ?", concept_name.downcase).first
  end

  ##
  # Returns all of the user's basic notes
  def basic_notes
    BasicNote.joins(article: { book: :books_users }).where(books_users: { user_id: id })
  end

  ##
  # Returns all of the user's cloze notes
  def cloze_notes
    ClozeNote.joins(article: { book: :books_users }).where(books_users: { user_id: id })
  end

  # :nodoc:
  def can_access_book?(book:)
    books.include?(book)
  end

  # :nodoc:
  def can_access_article?(article:)
    can_access_book?(book: article.book)
  end

  # :nodoc:
  def can_access_note?(note:)
    can_access_article?(article: note.article)
  end

  ##
  # Returns one of the user's articles that has reading: true and complete: false
  def random_reading_article
    articles.where(reading: true, complete: false).sample
  end

  ##
  # Returns one of the user's articles that has writing: true and complete: false
  def random_writing_article
    articles.where(writing: true, complete: false).sample
  end

  def update_anki_package(package_path:, name_for_attachment:)
    anki_package.purge
    anki_package.attach(io: File.open(package_path), filename: name_for_attachment)
  end
end
