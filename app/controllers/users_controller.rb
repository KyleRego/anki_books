# frozen_string_literal: true

# :nodoc:
class UsersController < ApplicationController
  before_action :require_login

  def download_anki_deck
    anki_deck_file_path = CreateUserAnkiDeck.perform(user: current_user)
    send_file(anki_deck_file_path, disposition: "attachment")
    DeleteAnkiDeckJob.set(wait: 3.minutes).perform_later(anki_deck_file_path:)
  end

  def random_article
    article = current_user.random_article
    redirect_to article_path(article)
  end
end
