# frozen_string_literal: true

require "pry"

# :nodoc:
class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show edit update]

  def show; end

  def edit; end

  def update
    if @article.update(article_params)
      flash[:notice] = "Article updated successfully."
      redirect_to @article
    else
      flash[:alert] = "There was an error updating the record."
      render :edit
    end
  end

  private

  def set_article
    @article = Article.first
  end

  def article_params
    params.require(:article).permit(:title, :content)
  end
end
