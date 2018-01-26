Rails.application.routes.draw do
  root to: 'brand/posts#index'

  namespace :admin do
    resources :posts
    resources :exercises do
      resources :submissions
    end
  end

  scope module: 'brand' do
    get 'about', to: 'pages#about'
    resources :posts, only: %i[index show]
  end

  resources :sessions, only: %i[new create destroy]
  get 'login', to: 'sessions#new'
  get 'logout', to: 'sessions#destroy'
end
