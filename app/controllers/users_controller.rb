# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

require "csv"

# :nodoc:
class UsersController < ApplicationController
  before_action :require_login

  def download_anki_deck
    anki_deck_file_path = AnkiPackages::CreateUserAnkiPackageJob.perform_now(user: current_user)
    send_file(anki_deck_file_path, disposition: "attachment")
    DeleteAnkiPackageJob.set(wait: 3.minutes).perform_later(anki_deck_file_path:)
  end

  def update_anki_deck
    # TODO: For real users, it will be necessary to check they are not spamming
    # this endpoint
    UpdateUserAnkiPackageJob.perform_later(user: current_user)
    redirect_to downloads_path, flash: { notice: "Job queued successfully" }
  end

  # :nocov:

  def download_books_data
    attributes = %w[id title parent_book_id]

    data = CSV.generate(headers: true) do |csv|
      csv << attributes

      current_user.books.each do |book|
        csv << attributes.map { |attr| book.send(attr) }
      end
    end

    send_data data, filename: "books.csv"
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

  def download_concepts_data
    attributes = %w[id name]

    data = CSV.generate(headers: true) do |csv|
      csv << attributes

      current_user.concepts.each do |concept|
        csv << attributes.map { |attr| concept.send(attr) }
      end
    end

    send_data data, filename: "concepts.csv"
  end

  def download_basic_notes_data
    attributes = %w[id front back article_id]

    data = CSV.generate(headers: true) do |csv|
      csv << attributes

      current_user.basic_notes.each do |basic_note|
        csv << attributes.map { |attr| basic_note.send(attr) }
      end
    end

    send_data data, filename: "basic_notes.csv"
  end

  def download_cloze_notes_data
    attributes = %w[id sentence article_id]

    data = CSV.generate(headers: true) do |csv|
      csv << attributes

      current_user.cloze_notes.each do |cloze_note|
        csv << attributes.map { |attr| cloze_note.send(attr) }
      end
    end

    send_data data, filename: "cloze_notes.csv"
  end

  def download_concepts_notes_data
    attributes = %w[note_id concept_id]

    data = CSV.generate(headers: true) do |csv|
      csv << attributes

      current_user.concepts.each do |concept|
        concept.concepts_notes.each do |concept_note|
          csv << attributes.map { |attr| concept_note.send(attr) }
        end
      end
    end

    send_data data, filename: "concept_notes.csv"
  end

  # :nocov:

  def random_writing_article
    article = current_user.random_writing_article
    if article
      redirect_to article_path(article)
    else
      flash[:notice] = "No incomplete writing articles found."
      redirect_to books_path
    end
  end
end
