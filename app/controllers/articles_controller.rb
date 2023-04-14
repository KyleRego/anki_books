# frozen_string_literal: true

require "pry"

class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update]

  def show
    @article = Article.first
    binding.pry
  end

  def edit
    @article = Article.first
  end

  def update
    if @article.update(article_params)
      redirect_to @article
    else
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
