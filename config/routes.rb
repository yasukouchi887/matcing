Rails.application.routes.draw do
  root to: 'profiles#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :users do
    member do
      get :followings
      get :followers
      get :matchings
    end
  end
  
  resources :microposts, only: [:create, :destroy]
  resources :relationships, only: [:create, :update, :destroy]
  resources :rooms, only: [:show]
end
