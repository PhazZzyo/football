Rails.application.routes.draw do
  resources :predictions
  resources :matches
  resources :teams
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get 'users/index'
  root "users#index"

  # Defines the root path route ("/")
  # root "articles#index"
end
