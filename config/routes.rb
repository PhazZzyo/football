Rails.application.routes.draw do  
    devise_for :users
    resources :predictions, :matches, :teams, :users, :scoreboard  
    
    # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
    get 'home/about'
    # root "home#index"
    root "users#index"
    
    # Defines the root path route ("/")
    # root "articles#index"
    
    namespace :api do
        namespace :v1 do
            resources :matches
            get '/get_token', to: 'application_api#get_token'
            post '/authorize_request', to: 'application_api#authorization'
        end
    end
end
