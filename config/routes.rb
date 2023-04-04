# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'landing#index'
  get "/login", to: "users#login_form"
  post "/login", to: "users#login"
  get "/logout", to: "sessions#destroy"

  get '/register', to: 'users#new'
  post '/register', to: 'users#create'

  resources :users, only: [:show, :create] do
    resources :discover, only: [:index]
    resources :movies, only: [:index, :show] do
      resources :viewing_parties, :path => '/viewing-party', only: [:new, :create]
    end
  end
end
