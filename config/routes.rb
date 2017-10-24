Rails.application.routes.draw do
  namespace :admin do
    resources :posts, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  end
  resources :sessions, only: [:new, :create, :destroy]
  get 'login', to: 'sessions#new'
end
