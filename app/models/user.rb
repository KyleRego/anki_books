# frozen_string_literal: true

##
# User model representing a registered user in the system.
class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 12 }

  has_secure_password
end
