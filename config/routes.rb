Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users
      resources :contacts
    end
  end
  root 'courts#index'
  get '/search', to: 'courts#search'
  get '/user_create', to: 'users#new'
  resources :users
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :courts
  post '/courts', to: 'courts#create'
  post '/guest_login', to: "guest_sessions#create"
  resources :contacts
  resources :courts do
    resources :comments, only: [:create, :destroy]
    resources :favorites, only: [:create, :destroy]
  end
  
end
