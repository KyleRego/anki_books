# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root "articles#homepage"
  get "/articles/:uuid/:title/edit", to: "articles#edit", as: "edit_article"
  get "/articles/:uuid/:title", to: "articles#show", as: "article"
  patch "/articles/:uuid/:title", to: "articles#update"
  put "/articles/:uuid/:title", to: "articles#update"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy", as: "logout"
  get "/users/:uuid/articles", to: "users#articles", as: "user_articles"
end
