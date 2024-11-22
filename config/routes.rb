Rails.application.routes.draw do
  devise_for :users
  root "books#index"


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :books do
    member do
      post "add_to_cart"
      patch "update_quantity"
      delete "remove_from_cart"
    end
    collection do
      get "new_books"
      get "updated_books"
    end
  end
  resources :genres

  get "cart", to: "carts#show", as: "cart"

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
end
