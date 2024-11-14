Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root 'products#index'

  # Products route
  resources :products, only: [:index, :show] do
    post 'add_to_cart', on: :member # POST route for adding to cart
  end

  # Cart route
  get '/cart', to: 'cart#index', as: :cart
  resources :cart, only: [:index] do
    member do
      patch :update_quantity
    end
  end

  # Signup route
  get '/signup', to: 'signup#index', as: :signup
  post '/signup/step1', to: 'signup#step1'
  get '/signup/step2', to: 'signup#step2'
  post '/signup', to: 'signup#create'

  # Login route
  get '/login', to: 'login#index', as: :login
  post '/login', to: 'login#create'

  # Logout route
  delete '/logout', to: 'sessions#destroy', as: :logout
end
