# frozen_string_literal: true

# :nodoc:
class ArticlesController < ApplicationController
  before_action :require_login, only: %i[new edit update]
  before_action :set_article, only: %i[show edit update]

  def show; end

  def new
    @article = Article.create title: "New article"
    redirect_to edit_article_path(@article, title: @article.title_slug)
  end

  def edit; end

  def update
    if @article.update(article_params)
      flash[:notice] = "Article updated successfully."
      redirect_to article_path(@article, title: @article.title_slug)
    else
      render :edit
    end
  end

  def homepage
    # Plan is to have more than one system article in the future.
    # For now, just have one and it will serve as the homepage.
    @article = Article.find_by system: true
    render :show
  end

  private

  def set_article
    @article = Article.find_by id: params[:uuid]
  end

  def article_params
    params.require(:article).permit(:title, :content)
  end
end
