# frozen_string_literal: true

##
# UsersController handles user registration and management and other actions
# related to users.
class UsersController < ApplicationController
  before_action :require_login, :set_articles

  def books
    @books = current_user.books
  end

  def manage_articles; end

  private

  def set_articles
    @articles = Article.all.order(:title)
  end
end
