Rails.application.routes.draw do
  root 'tennis#home'
  get '/search', to: 'tennis#search'
  get '/contact', to: 'tennis#contact'
  get '/user_create', to: 'users#new'
  resources :users
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :user_activations, only: [:edit]
end
