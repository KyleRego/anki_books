# frozen_string_literal: true

# :nodoc:
class DomainsController < ApplicationController
  before_action :require_login
  before_action :set_domain, only: %i[show edit update manage change_books change_parent_domains change_child_domains destroy]
  before_action :set_books, only: %i[show]

  def index
    @domains = current_user.domains.order(:title)
  end

  def show
    @parent_domains = @domain.parent_domains
    @child_domains = @domain.child_domains
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def manage
    domain_current_books = @domain.books.order(:title)
    @books_options = current_user.books.map do |book|
      id = book.id
      title = book.title
      selected = domain_current_books.include?(book)
      { id:, title:, selected: }
    end
    domains_options = current_user.domains
    @parent_domains = @domain.parent_domains
    @child_domains = @domain.child_domains
    @parent_domains_options = domains_options.map do |domain|
      { id: domain.id, title: domain.title, selected: @parent_domains.include?(domain) }
    end
    @child_domains_options = domains_options.map do |domain|
      { id: domain.id, title: domain.title, selected: @child_domains.include?(domain) }
    end
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

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

  def destroy
    @domain.destroy!
    redirect_to books_path, flash: { success: "Domain successfully deleted" }
  end

  def change_books
    @domain.books = current_user.books.where(id: params[:book_ids])
    redirect_to manage_domain_path(@domain), flash: { notice: "Books updated" }
  end

  def change_parent_domains
    parent_domain_ids = params[:parent_domain_ids]
    @domain.parent_domains = current_user.domains.where(id: parent_domain_ids)
    redirect_to manage_domain_path(@domain), flash: { notice: "Parent domains updated" }
  end

  def change_child_domains
    child_domain_ids = params[:child_domain_ids]
    @domain.child_domains = current_user.domains.where(id: child_domain_ids)
    redirect_to manage_domain_path(@domain), flash: { notice: "Child domains updated" }
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
