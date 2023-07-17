# frozen_string_literal: true

# :nodoc:
class BookGroupsController < ApplicationController
  before_action :require_login
  before_action :set_book_group, only: %i[edit update show]
  before_action :set_books, only: %i[show]

  def index
    @book_groups = current_user.book_groups
  end

  def show; end

  def new
    @book_group = BookGroup.new
  end

  def edit; end

  def create
    @book_group = current_user.book_groups.create(book_group_params)
    if @book_group.save
      redirect_to book_groups_path, flash: { notice: "#{@book_group.title} created successfully" }
    else
      flash.now[:alert] = @book_group.errors.full_messages.first
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @book_group.update(book_group_params)
      redirect_to book_groups_path, flash: { notice: "#{@book_group.title} updated successfully" }
    else
      flash.now[:alert] = @book_group.errors.full_messages.first
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def book_group_params
    params.require(:book_group).permit(:title)
  end

  def set_book_group
    @book_group = current_user.book_groups.find_by(id: params[:id])
    return if @book_group

    redirect_to root_path, flash: { alert: "Book group not found" }
  end

  def set_books
    @books = @book_group.books
  end
end
