# frozen_string_literal: true

Rails.application.routes.draw do
  root "articles#homepage"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy", as: "logout"

  get "/articles/:id/:title/edit", to: "articles#edit", as: "edit_article"
  get "/articles/:id/:title", to: "articles#show", as: "article"
  patch "/articles/:id/:title", to: "articles#update"
  put "/articles/:id/:title", to: "articles#update"
  post "/articles/:id/change_note_ordinal_position", to: "articles#change_note_ordinal_position",
                                                     as: "article_change_note_ordinal_position"

  get "/users/:user_id/articles", to: "users#articles", as: "user_articles"
  post "/users/:user_id/articles", to: "articles#create", as: "new_article"

  resources :articles, only: [], param: :id do
    resources :basic_notes, only: %i[new create edit update show]
  end
end
