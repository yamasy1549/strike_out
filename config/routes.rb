Rails.application.routes.draw do
  root to: 'results#index'

  devise_for :users
  resources :results, except: [:show]
end
