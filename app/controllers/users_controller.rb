# frozen_string_literal: true

##
# UsersController handles user registration and management and other actions
# related to users.
class UsersController < ApplicationController
  ##
  # Index of the user's articles.
  def articles
    @articles = Article.all.order(:title)
  end
end
