# frozen_string_literal: true

Rails.application.routes.draw do
  root "articles#homepage"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy", as: "logout"

  resources :articles, except: %i[new]
  post "/articles/:id/change_note_ordinal_position", to: "articles#change_note_ordinal_position",
                                                     as: "change_article_note_ordinal_position"
  patch "/articles/:id/change_book", to: "articles#change_book", as: "change_article_book"
  patch "/articles/:id/transfer_basic_notes", to: "articles#transfer_basic_notes", as: "article_transfer_basic_notes"
  get "/articles/:id/study_cards", to: "articles#study_cards", as: "study_article_cards"
  get "/articles/:id/manage", to: "articles#manage", as: "manage_article"

  resources :book_groups, except: %i[destroy]
  resources :books, except: %i[destroy] do
    resources :articles, only: :new
  end
  get "/books/:id/manage", to: "books#manage", as: "manage_book"
  get "/books/:id/study_cards", to: "books#study_cards", as: "study_book_cards"
  post "/books/:id/change_article_ordinal_position", to: "books#change_article_ordinal_position",
                                                     as: "change_book_article_ordinal_position"

  get "/download_anki_deck", to: "users#download_anki_deck", as: "user_download_anki_deck"
  get "/random_article", to: "users#random_article", as: "user_random_article"

  resources :articles, only: [], param: :id do
    resources :basic_notes, only: %i[new create edit update show]
  end
end
