Rails.application.routes.draw do
  resources :users, except: [:show]

  resources :user_sessions, only: [:new, :create, :destroy]

  root to: 'users#index'

  get 'login' => 'user_sessions#new', as: :login
  post 'logout' => 'user_sessions#destroy', as: :logout
end
