# frozen_string_literal: true

Rails.application.routes.draw do

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'landing#index'

  get '/register', to: 'users#new'
  post '/register', to: 'users#create'

	get '/login', to: 'users#login_form'
	post '/login', to: 'users#login_user'

  resources :users, only: %i[show create] do
    resources :discover, only: [:index]
    resources :movies, only: %i[index show] do
      resources :viewing_parties, :path => '/viewing-party', only: [:new, :create]
    end
  end
end
