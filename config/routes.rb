# frozen_string_literal: true

Rails.application.routes.draw do
  root "articles#homepage"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy", as: "logout"

  resources :articles
  post "/articles/:id/change_note_ordinal_position", to: "articles#change_note_ordinal_position",
                                                     as: "change_article_note_ordinal_position"
  get "/articles/:id/study_cards", to: "articles#study_cards", as: "study_article_cards"
  get "/articles/:id/manage", to: "articles#manage", as: "manage_article"

  resources :books, except: %i[edit update index destroy] do
    resources :articles, only: :new
  end
  get "/books/:id/manage", to: "books#manage", as: "manage_book"

  get "/users/:id/books", to: "users#books", as: "user_books"
  get "/users/:id/download_anki_deck", to: "users#download_anki_deck", as: "user_download_anki_deck"

  resources :articles, only: [], param: :id do
    resources :basic_notes, only: %i[new create edit update show]
  end
end
