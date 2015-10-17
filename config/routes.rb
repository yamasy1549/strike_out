Rails.application.routes.draw do
  root to: 'results#index'

  devise_for :users, only: [:sign_in, :sign_out, :session]
  resources :results, except: [:show]
end
