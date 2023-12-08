Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root 'homes#index'
  get '/users/dashboard', to: 'users#dashboard'
  get '/users/profile', to: 'users#profile'
  resources :cards, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  resources :transactions, only: [:index, :show, :new, :create]
  resources :users, only: [:index, :show, :new, :create, :update]
  resources :sessions, only: [:new, :create, :destroy]
  resources :relations, only: [:index, :create, :destroy]
end
