Rails.application.routes.draw do
  devise_for :users
  get '/test', to: 'test#index'
end
