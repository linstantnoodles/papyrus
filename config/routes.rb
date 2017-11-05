Rails.application.routes.draw do
  root to: 'posts#index'

  namespace :admin do
    resources :posts
  end

  resources :posts, only: [:index, :show]

  resources :sessions, only: [:new, :create, :destroy]
  get 'login', to: 'sessions#new'
  get 'logout', to: 'sessions#destroy'
end
