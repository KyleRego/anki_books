# frozen_string_literal: true

require "csv"

# :nodoc:
class UsersController < ApplicationController
  before_action :require_login

  def download_anki_deck
    anki_deck_file_path = CreateUserAnkiDeck.perform(user: current_user)
    send_file(anki_deck_file_path, disposition: "attachment")
    DeleteAnkiDeckJob.set(wait: 3.minutes).perform_later(anki_deck_file_path:)
  end

  # :nocov:
  def download_books_data
    attributes = %w[id title]

    data = CSV.generate(headers: true) do |csv|
      csv << attributes

      current_user.books.each do |book|
        csv << attributes.map { |attr| book.send(attr) }
      end
    end

    send_data data, filename: "books.csv"
  end

  def download_books_domains_data
    attributes = %w[book_id domain_id]

    data = CSV.generate(headers: true) do |csv|
      csv << attributes

      current_user.books.each do |book|
        book.books_domains.each do |books_domain|
          csv << attributes.map { |attr| books_domain.send(attr) }
        end
      end
    end

    send_data data, filename: "books_domains.csv"
  end

  def download_domains_data
    attributes = %w[id title]

    data = CSV.generate(headers: true) do |csv|
      csv << attributes

      current_user.domains.each do |domain|
        csv << attributes.map { |attr| domain.send(attr) }
      end
    end

    send_data data, filename: "domains.csv"
  end

  def download_domains_domains_data
    attributes = %w[parent_domain_id child_domain_id]

    data = CSV.generate(headers: true) do |csv|
      csv << attributes

      current_user.domains_domains.each do |domains_domain|
        csv << attributes.map { |attr| domains_domain.send(attr) }
      end
    end

    send_data data, filename: "domains_domains.csv"
  end

  def download_articles_data
    attributes = %w[id title book_id]

    data = CSV.generate(headers: true) do |csv|
      csv << attributes

      current_user.books.each do |book|
        book.articles.each do |article|
          csv << attributes.map { |attr| article.send(attr) }
        end
      end
    end

    send_data data, filename: "articles.csv"
  end

  def download_basic_notes_data
    attributes = %w[id front back article_id]

    data = CSV.generate(headers: true) do |csv|
      csv << attributes

      current_user.notes.each do |basic_note|
        csv << attributes.map { |attr| basic_note.send(attr) }
      end
    end

    send_data data, filename: "basic_notes.csv"
  end
  # :nocov:

  def random_article
    article = current_user.random_article
    redirect_to article_path(article)
  end
end
