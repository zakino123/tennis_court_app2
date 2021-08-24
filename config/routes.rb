Rails.application.routes.draw do
  root 'tennis#home'
  get 'tennis/search'
end
