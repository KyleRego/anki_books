# frozen_string_literal: true

##
# User model representing a registered user in the system.
class User < ApplicationRecord
  has_secure_password
  has_many :books_users, dependent: :destroy
  has_many :books, through: :books_users

  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 12 }
end
