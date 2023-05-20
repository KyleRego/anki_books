# frozen_string_literal: true

##
# UsersController handles user registration and management and other actions
# related to users.
class UsersController < ApplicationController
  before_action :require_login, :set_articles

  def books
    @books = user_books
  end

  private

  def set_articles
    @articles = Article.all.order(:title)
  end

  def user_books
    current_user.books.order(:title)
  end
end
