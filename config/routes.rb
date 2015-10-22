Rails.application.routes.draw do
  resources :users, except: [:show]

  root to: 'users#index'
end
