# frozen_string_literal: true

Rails.application.routes.draw do
  get '/sign_in', to: 'sessions#new'
	get '/sign_out', to: 'sessions#destroy'
	resource :sessions, only: %i[create]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'landing#index'

  get '/register', to: 'users#new'
  post '/register', to: 'users#create'

  resources :users, only: %i[show create] do
    resources :discover, only: [:index]
    resources :movies, only: %i[index show] do
      resources :viewing_parties, :path => '/viewing-party', only: [:new, :create]
    end
  end
end
