Rails.application.routes.draw do
  root to: 'brand/posts#index'

  namespace :admin do
    resources :posts do
      member do
        get 'publish', to: 'posts#publish'
        get 'unpublish', to: 'posts#unpublish'
      end
    end
    resources :exercises do
      member do
        get 'practice', to: 'exercises#practice'
      end
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
