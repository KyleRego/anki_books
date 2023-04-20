# frozen_string_literal: true

##
# UsersController handles user registration and management.
class UsersController < ApplicationController
  ##
  # Index of the user's articles.
  def articles
    @articles = Article.all.order(:title)
  end
end
