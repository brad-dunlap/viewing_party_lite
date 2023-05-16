Rails.application.routes.draw do
  root 'landing#index'

  get '/register', to: 'users#new'
  post '/register', to: 'users#create'

  get '/login', to: 'users#login_form'
  post '/login', to: 'users#login_user'
  get '/logout', to: 'users#logout_user'

  get '/discover', to: 'discover#show'

  delete '/dashboard/movies/:movie_id/viewing-party/:party_id', to: 'viewing_parties#destroy', as: 'user_movie_viewing_party'

  resource :user, only: [:show], path: '/dashboard' do
    resources :discover, only: [:index]
    resources :movies, only: [:index, :show] do
      collection do
        get :search # Route for searching movies without query parameters
      end
      resources :viewing_parties, path: 'viewing-party', only: [:new, :create, :edit, :update]
    end
  end

  resources :users, only: [:create]
end