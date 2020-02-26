Rails.application.routes.draw do
  root to: 'profiles#index'
  
  get 'signup', to: 'users#new'
  resources :users
end
