Rails.application.routes.draw do
  root to: 'results#new'

  devise_for :users, only: [:sign_in, :sign_out, :session]
  resources :results, except: [:show]
end
