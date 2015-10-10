Rails.application.routes.draw do
  resources :results, except: [:show]
end
