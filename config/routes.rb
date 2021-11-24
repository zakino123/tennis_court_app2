Rails.application.routes.draw do
  root 'courts#index'
  get '/search', to: 'courts#search'
  get '/user_create', to: 'users#new'
  resources :users
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :courts
  get '/court_create', to: 'courts#new'
  post '/courts', to: 'courts#create'
  post '/guest_login', to: 'guest_sessions#create'
  resources :contacts
  resources :courts do
    resources :comments, only: %i[create destroy]
    resources :favorites, only: %i[create destroy]
  end
  resources :tags do
    get 'courts', to: 'courts#tagsearch'
  end
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :follow_relationships, only: %i[create destroy]

  namespace :api, { format: 'json' } do
    namespace :v1 do
      get '/login', to: 'sessions#new'
      post '/login', to: 'sessions#create'
      delete '/logout', to: 'sessions#destroy'
      get '/user_create', to: 'users#new'
      get '/favorite_court/:id', to: 'users#favorite_court'
      get '/post_court/:id', to: 'users#post_court'
      get '/court_count/:id', to: 'users#court_count'
      resources :users
      resources :courts
      get '/court_create', to: 'courts#new'
      post '/courts', to: 'courts#create'
      get '/taglist', to: 'courts#taglist'
      get '/court_rank', to: 'courts#court_rank'
      get '/latest_court', to: 'courts#latest_court'
      get '/court_tag/:id', to: 'courts#court_tag'
      get '/favorite_count/:id', to: 'favorites#favorite_count'
      get '/tagsearch/:id', to: 'courts#tagsearch'
      get '/comment_count/:id', to: 'comments#comment_count'
      delete '/court/:court_id/user/:user_id/favorite', to: 'favorites#destroy'
      get '/court/:court_id/user/:user_id/favorite', to: 'favorites#show'
      resources :courts do
        resources :comments, only: %i[create destroy]
        # resources :favorites, only: %i[create destroy]
        resources :favorites, only: %i[create]
      end
      resources :contacts
      resources :follow_relationships, only: %i[create destroy]
    end
  end
end
