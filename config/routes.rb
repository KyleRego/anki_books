# frozen_string_literal: true

Rails.application.routes.draw do
  root "homepage#show"
  # Dependency: paths that render study_cards/index must end with /study_cards
  get "/study_cards", to: "homepage#study_cards", as: "homepage_study_cards"
  get "/articles/:id/study_cards", to: "articles#study_cards", as: "study_article_cards"
  get "/books/:id/study_cards", to: "books#study_cards", as: "study_book_cards"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy", as: "logout"

  resources :articles, except: %i[new]
  post "/articles/:id/change_note_ordinal_position", to: "articles#change_note_ordinal_position",
                                                     as: "change_article_note_ordinal_position"
  patch "/articles/:id/change_book", to: "articles#change_book", as: "change_article_book"
  patch "/articles/:id/transfer_basic_notes", to: "articles#transfer_basic_notes", as: "article_transfer_basic_notes"
  get "/articles/:id/manage", to: "articles#manage", as: "manage_article"

  resources :domains
  patch "/domains/:id/change_books", to: "domains#change_books", as: "change_domain_books"
  patch "/domains/:id/change_parent_domains", to: "domains#change_parent_domains", as: "change_parent_domains"
  patch "/domains/:id/change_child_domains", to: "domains#change_child_domains", as: "change_child_domains"

  resources :books, except: %i[destroy] do
    resources :articles, only: :new
  end
  get "/books/:id/manage", to: "books#manage", as: "manage_book"
  post "/books/:id/change_article_ordinal_position", to: "books#change_article_ordinal_position",
                                                     as: "change_book_article_ordinal_position"
  patch "/books/:id/change_domains", to: "books#change_domains", as: "change_book_domains"

  get "/download_anki_deck", to: "users#download_anki_deck", as: "user_download_anki_deck"
  get "/random_article", to: "users#random_article", as: "user_random_article"

  resources :articles, only: [], param: :id do
    resources :basic_notes, only: %i[new create edit update show]
  end

  get "/downloads", to: "users#downloads", as: "downloads"
  # TODO: This is tech debt as I wanted to get this automated quickly
  # It should be one download with a zip file of what these endpoints give individually.
  get "/download_books_data", to: "users#download_books_data", as: "download_books_data"
  get "/download_books_domains_data", to: "users#download_books_domains_data", as: "download_books_domains_data"
  get "/download_domains_data", to: "users#download_domains_data", as: "download_domains_data"
  get "/download_articles_data", to: "users#download_articles_data", as: "download_articles_data"
  get "/download_basic_notes_data", to: "users#download_basic_notes_data", as: "download_basic_notes_data"
end
