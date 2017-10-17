Rails.application.routes.draw do
  namespace :admin do
    resources :posts, only: [:index, :new, :create, :show, :edit, :update]
  end
end
