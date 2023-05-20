# frozen_string_literal: true

# :nodoc:
class UsersController < ApplicationController
  include AnkiRecord::Helpers::TimeHelper

  before_action :require_login, :set_articles

  def books
    @books = user_books
  end

  def download_anki_deck
    anki_deck_name = "anki_books_package_#{milliseconds_since_epoch}"
    target_directory = Dir.tmpdir
    CreateUserAnkiDeck.perform(user: current_user, anki_deck_name:, target_directory:)
    anki_deck_file_path = "#{target_directory}/#{anki_deck_name}.apkg"
    send_file(anki_deck_file_path, disposition: "attachment")
    DeleteAnkiDeckJob.set(wait: 3.minutes).perform_later(anki_deck_file_path:)
  end

  private

  def set_articles
    @articles = Article.all.order(:title)
  end

  def user_books
    current_user.books.order(:title)
  end
end
