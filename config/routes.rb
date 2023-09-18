# Anki Books, a note-taking app to organize knowledge,
# is licensed under the GNU Affero General Public License, version 3
# Copyright (C) 2023 Kyle Rego

# frozen_string_literal: true

Rails.application.routes.draw do
  root "homepage#show"
  # Dependency: paths that render study_cards/index must end with /study_cards
  get "/study_cards", to: "homepage#study_cards", as: "homepage_study_cards"
  get "/articles/:id/study_cards", to: "articles#study_cards", as: "study_article_cards"
  get "/books/:id/study_cards", to: "books#study_cards", as: "study_book_cards"
  get "/domains/:id/study_cards", to: "domains#study_cards", as: "study_domain_cards"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy", as: "logout"

  resources :articles, except: %i[new index]
  get "/articles/:id/manage", to: "articles#manage", as: "manage_article"
  post "/articles/:id/change_note_ordinal_position", to: "articles#change_note_ordinal_position",
                                                     as: "change_article_note_ordinal_position"
  patch "/articles/:id/change_book", to: "articles#change_book", as: "change_article_book"
  patch "/articles/:id/transfer_basic_notes", to: "articles#transfer_basic_notes", as: "article_transfer_basic_notes"

  resources :domains
  get "/root_domains", to: "domains#root_domains", as: "root_domains"
  get "/domains/:id/manage", to: "domains#manage", as: "manage_domain"
  patch "/domains/:id/change_books", to: "domains#change_books", as: "change_domain_books"
  patch "/domains/:id/change_child_domains", to: "domains#change_child_domains", as: "change_child_domains"

  resources :concepts, except: %i[destroy]
  get "/concepts/:id/manage", to: "concepts#manage", as: "manage_concept"

  resources :books, except: %i[destroy] do
    resources :articles, only: %i[new index]
  end
  get "/books/:id/manage", to: "books#manage", as: "manage_book"
  post "/books/:id/change_article_ordinal_position", to: "books#change_article_ordinal_position",
                                                     as: "change_book_article_ordinal_position"
  patch "/books/:id/change_domains", to: "books#change_domains", as: "change_book_domains"
  patch "/books/:id/change_concepts", to: "books#change_concepts", as: "change_book_concepts"
  patch "/books/:id/transfer_articles", to: "books#transfer_articles", as: "book_transfer_articles"

  get "/download_anki_deck", to: "users#download_anki_deck", as: "user_download_anki_deck"
  get "/random_article", to: "users#random_article", as: "user_random_article"

  resources :articles, only: [], param: :id do
    resources :basic_notes, only: %i[new create edit update show]
  end

  get "/downloads", to: "users#downloads", as: "downloads"
  # TODO: This is tech debt as I wanted to get this automated quickly
  # It should be one download with a zip file of what these endpoints give individually.
  # :nocov:
  get "/download_books_data", to: "users#download_books_data", as: "download_books_data"
  get "/download_books_domains_data", to: "users#download_books_domains_data", as: "download_books_domains_data"
  get "/download_domains_data", to: "users#download_domains_data", as: "download_domains_data"
  get "/download_articles_data", to: "users#download_articles_data", as: "download_articles_data"
  get "/download_basic_notes_data", to: "users#download_basic_notes_data", as: "download_basic_notes_data"
  # :nocov:
end
