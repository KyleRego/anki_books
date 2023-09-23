# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

require "csv"

# rubocop:disable Metrics/ClassLength

# :nodoc:
class UsersController < ApplicationController
  before_action :require_login

  def download_anki_deck
    anki_deck_file_path = CreateUserAnkiPackageJob.perform_now(user: current_user)
    send_file(anki_deck_file_path, disposition: "attachment")
    DeleteAnkiPackageJob.set(wait: 3.minutes).perform_later(anki_deck_file_path:)
  end

  def download_domains_data
    attributes = %w[id title parent_domain_id]

    data = CSV.generate(headers: true) do |csv|
      csv << attributes

      current_user.domains.each do |domain|
        csv << attributes.map { |attr| domain.send(attr) }
      end
    end

    send_data data, filename: "domains.csv"
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
    attributes = %w[id sentence]

    data = CSV.generate(headers: true) do |csv|
      csv << attributes

      current_user.cloze_notes.each do |cloze_note|
        csv << attributes.map { |attr| cloze_note.send(attr) }
      end
    end

    send_data data, filename: "cloze_notes.csv"
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

  def download_articles_concepts_data
    attributes = %w[article_id concept_id]

    data = CSV.generate(headers: true) do |csv|
      csv << attributes

      current_user.concepts.each do |concept|
        concept.articles_concepts.each do |articles_concept|
          csv << attributes.map { |attr| articles_concept.send(attr) }
        end
      end
    end

    send_data data, filename: "articles_concepts.csv"
  end

  def download_cloze_notes_concepts_data
    attributes = %w[cloze_note_id concept_id]

    data = CSV.generate(headers: true) do |csv|
      csv << attributes

      current_user.concepts.each do |concept|
        concept.cloze_notes_concepts.each do |cloze_notes_concept|
          csv << attributes.map { |attr| cloze_notes_concept.send(attr) }
        end
      end
    end

    send_data data, filename: "cloze_notes_concepts.csv"
  end

  # :nocov:

  def random_article
    article = current_user.random_article
    redirect_to article_path(article)
  end
end

# rubocop:enable Metrics/ClassLength
