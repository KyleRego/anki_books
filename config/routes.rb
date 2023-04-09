Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root "tests#show"
  resources :articles, only: [:show, :edit, :update], param: :uuid
end
