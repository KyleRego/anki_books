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

  def notes
    BasicNote.joins("inner join articles on basic_notes.article_id = articles.id
                     inner join books on articles.book_id = books.id
                     inner join books_users on books_users.book_id = books.id
                     inner join users on books_users.user_id = users.id
                     where users.id = '#{id}'")
  end

  def random_article
    Article.joins("inner join books on articles.book_id = books.id
                   inner join books_users on books_users.book_id = books.id
                   inner join users on books_users.user_id = users.id
                   where users.id = '#{id}'").sample
  end
end
