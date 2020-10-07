Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:index]
  
  get 'comments/create'
  
  resources :blogs do
    resources :comments
  end
  
  root "blogs#index"

  resources :relationships, only: [:create, :destroy]
end
