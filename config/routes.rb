Rails.application.routes.draw do

  devise_for :users
  resources  :sessions, only: [:create, :destroy]


  resources :users, only: [:show, :create, :update, :destroy] do
    resources :timezones, only: [:create, :update, :destroy]
  end
  
  resources :timezones, :only => [:show, :index]

  get '/test', to: 'test#index'
end
