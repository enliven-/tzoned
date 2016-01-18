Rails.application.routes.draw do
  devise_for :users
  resources  :users, only: [:show, :create]
  
  get '/test', to: 'test#index'
end
