Rails.application.routes.draw do
  root to: 'brand/posts#index'

  namespace :api do
    resources :posts, only: [:create]
  end

  namespace :admin do
    get 'statistics', to: 'statistics#index'
    resources :posts do
      member do
        get 'publish', to: 'posts#publish'
        get 'unpublish', to: 'posts#unpublish'
      end
      resources :posts, only: %i[new create]
    end
    resources :exercises do
      member do
        get 'practice', to: 'exercises#practice'
      end
      resources :submissions
    end
    resources :cards do
      collection do
        get 'review_all(/:tag)', to: 'cards#review_all'
      end
      member do
        get 'show_front'
        get 'show_back'
        post 'review'
      end
    end
    resources :tags, only: %i[index]
  end

  scope module: 'brand' do
    get 'about', to: 'pages#about'
    get 'til', to: 'pages#til'
    get 'book-notes', to: 'pages#book_notes'
    resources :posts, only: %i[index show], param: :slug do
      get 'preview', on: :member
    end
  end

  resources :sessions, only: %i[new create destroy]
  get 'login', to: 'sessions#new'
  get 'logout', to: 'sessions#destroy'
end
