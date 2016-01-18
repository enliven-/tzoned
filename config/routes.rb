Rails.application.routes.draw do
  devise_for :users
  resources  :users, only: [:show]
  
  get '/test', to: 'test#index'
end
