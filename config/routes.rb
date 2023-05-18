# frozen_string_literal: true

Rails.application.routes.draw do
  root "articles#homepage"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy", as: "logout"

  get "/articles/:id/:title", to: "articles#show", as: "article"
  get "/articles/:id/:title/edit", to: "articles#edit", as: "edit_article"
  patch "/articles/:id/:title", to: "articles#update"
  put "/articles/:id/:title", to: "articles#update"
  delete "/articles/:id/:title", to: "articles#destroy"
  post "/articles/:id/change_note_ordinal_position", to: "articles#change_note_ordinal_position",
                                                     as: "article_change_note_ordinal_position"
  get "/articles/:id/:title/study_cards", to: "articles#study_cards", as: "article_study_cards"

  get "/books/:id/:title", to: "books#show", as: "book"
  get "/books/:id/:title/edit", to: "books#edit", as: "edit_book"
  patch "/books/:id/:title", to: "books#update"
  put "/books/:id/:title", to: "books#update"
  resources :books, only: %i[new create] do
    resources :articles, only: :new
  end

  get "/users/:id/books", to: "users#books", as: "user_books"
  get "/users/:id/manage_articles", to: "users#manage_articles", as: "user_manage_articles"
  post "/users/:id/articles", to: "articles#create", as: "new_article"

  resources :articles, only: [], param: :id do
    resources :basic_notes, only: %i[new create edit update show]
  end
end
