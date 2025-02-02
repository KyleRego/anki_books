# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2025 Kyle Rego

# frozen_string_literal: true

Rails.application.routes.draw do
  root "homepage#show"
  # Dependency: paths that render study_cards/index must end with /study_cards
  get "/study_cards", to: "homepage#study_cards", as: "homepage_study_cards"
  get "/articles/:id/study_cards", to: "articles#study_cards", as: "study_article_cards"
  get "/books/:id/study_cards", to: "books#study_cards", as: "study_book_cards"

  get "/articles/:article_id/notes/new", to: "notes#new", as: "new_note"
  get "/articles/:article_id/notes/:id/edit", to: "notes#edit", as: "edit_note"
  get "/articles/:article_id/notes/new/switch_note_type", to: "notes#switch_note_type", as: "switch_note_type"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy", as: "logout"

  resources :articles, except: %i[new index]
  get "/articles/:id/manage", to: "articles#manage", as: "manage_article"
  post "/articles/:id/change_note_ordinal_position", to: "articles#change_note_ordinal_position",
                                                     as: "change_article_note_ordinal_position"
  patch "/articles/:id/change_book", to: "articles#change_book", as: "change_article_book"
  patch "/articles/:id/transfer_notes", to: "articles#transfer_notes", as: "article_transfer_notes"

  resources :concepts
  get "/concepts/:id/manage", to: "concepts#manage", as: "manage_concept"

  resources :books, except: %i[destroy] do
    resources :articles, only: %i[new]
  end
  get "/books/:id/manage", to: "books#manage", as: "manage_book"
  post "/books/:id/change_article_ordinal_position", to: "books#change_article_ordinal_position",
                                                     as: "change_book_article_ordinal_position"
  patch "/books/:id/transfer_articles", to: "books#transfer_articles", as: "book_transfer_articles"
  patch "/books/:id/change_parent_book", to: "books#change_parent_book", as: "change_parent_book"
  patch "/books/:id/update_child_books", to: "books#update_child_books", as: "update_child_books"

  get "/download_anki_deck", to: "users#download_anki_deck", as: "user_download_anki_deck"
  get "/update_anki_deck", to: "users#update_anki_deck", as: "user_update_anki_deck"
  get "/random_reading_article", to: "articles#random_article", as: "random_article"
  get "/random_writing_article", to: "users#random_writing_article", as: "user_random_writing_article"

  resources :articles, only: [], param: :id do
    resources :basic_notes, only: %i[new create edit update destroy]
    resources :cloze_notes, only: %i[new create edit update]
  end

  get "/downloads", to: "users#downloads", as: "downloads"
  # TODO: This is tech debt as I wanted to get this automated quickly
  # It should be one download with a zip file of what these endpoints give individually.
  # :nocov:
  get "/download_books_data", to: "users#download_books_data", as: "download_books_data"
  get "/download_articles_data", to: "users#download_articles_data", as: "download_articles_data"
  get "/download_concepts_data", to: "users#download_concepts_data", as: "download_concepts_data"
  get "/download_basic_notes_data", to: "users#download_basic_notes_data", as: "download_basic_notes_data"
  get "/download_cloze_notes_data", to: "users#download_cloze_notes_data", as: "download_cloze_notes_data"
  get "/download_concepts_notes_data", to: "users#download_concepts_notes_data", as: "download_concepts_notes_data"
  # :nocov:
end
