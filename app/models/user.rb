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

  has_many :domains, dependent: :destroy

  has_many :books_users, dependent: :destroy
  has_many :books, -> { order(:title) }, through: :books_users

  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 12 }

  ##
  # Returns all of the user's basic notes
  def notes
    BasicNote.joins("inner join articles on basic_notes.article_id = articles.id
                     inner join books on articles.book_id = books.id
                     inner join books_users on books_users.book_id = books.id
                     inner join users on books_users.user_id = users.id
                     where users.id = '#{id}'")
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
  # Returns a randomly selected article that belongs to the user
  def random_article
    Article.joins("inner join books on articles.book_id = books.id
                   inner join books_users on books_users.book_id = books.id
                   inner join users on books_users.user_id = users.id
                   where users.id = '#{id}'").sample
  end
end
