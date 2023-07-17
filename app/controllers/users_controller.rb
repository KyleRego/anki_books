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

  def download_book_groups_books_data
    attributes = %w[book_group_id book_id]

    data = CSV.generate(headers: true) do |csv|
      csv << attributes

      current_user.books.each do |book|
        book.book_groups_books.each do |book_groups_book|
          csv << attributes.map { |attr| book_groups_book.send(attr) }
        end
      end
    end

    send_data data, filename: "book_groups_books.csv"
  end

  def download_book_groups_data
    attributes = %w[id title]

    data = CSV.generate(headers: true) do |csv|
      csv << attributes

      current_user.book_groups.each do |book_group|
        csv << attributes.map { |attr| book_group.send(attr) }
      end
    end

    send_data data, filename: "book_groups.csv"
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
