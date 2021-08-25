Rails.application.routes.draw do
  root 'tennis#home'
  get '/search', to: 'tennis#search'
  get '/question', to: 'tennis#question'
  get '/contact', to: 'tennis#contact'
  get '/user_create', to: 'users#new'
end
