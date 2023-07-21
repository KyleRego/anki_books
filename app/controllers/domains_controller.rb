# frozen_string_literal: true

# :nodoc:
class DomainsController < ApplicationController
  before_action :require_login
  before_action :set_domain, only: %i[show edit update change_books]
  before_action :set_books, only: %i[show]

  def index
    @domains = current_user.domains.order(:title)
  end

  def show
    current_books = @domain.books.order(:title)
    @books_options = current_user.books.map do |book|
      id = book.id
      title = book.title
      selected = current_books.include?(book)
      { id:, title:, selected: }
    end
  end

  def new
    @domain = Domain.new
  end

  def edit; end

  def create
    @domain = current_user.domains.create(domain_params)
    if @domain.save
      redirect_to domains_path, flash: { notice: "#{@domain.title} created successfully" }
    else
      flash.now[:alert] = @domain.errors.full_messages.first
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @domain.update(domain_params)
      redirect_to domains_path, flash: { notice: "#{@domain.title} updated successfully" }
    else
      flash.now[:alert] = @domain.errors.full_messages.first
      render :edit, status: :unprocessable_entity
    end
  end

  def change_books
    @domain.books = current_user.books.where(id: params[:book_ids])
    redirect_to domain_path(@domain), flash: { notice: "Books updated" }
  end

  private

  def domain_params
    params.require(:domain).permit(:title)
  end

  def set_domain
    @domain = current_user.domains.find_by(id: params[:id])
    return if @domain

    redirect_to root_path, flash: { alert: "domain not found" }
  end

  def set_books
    @books = @domain.books
  end
end
