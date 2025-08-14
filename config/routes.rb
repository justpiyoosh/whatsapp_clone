Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Action Cable
  mount ActionCable.server => "/cable"

  # Authentication routes
  get "signup", to: "users#new"
  post "signup", to: "users#create"
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  # Messaging routes
  get "messages", to: "messages#index"
  post "messages", to: "messages#create"
  get "messages/:recipient_username", to: "messages#index", as: :chat_with
  get "messages/:recipient_username/test", to: "messages#test_broadcast", as: :test_broadcast

  # Defines the root path route ("/")
  root "home#index"
end
