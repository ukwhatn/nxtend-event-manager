Rails.application.routes.draw do
  # public/common
  root "public/common#top"
  get "401", to: "public/common#unauthorized"

  # public/auth
  post "auth/discord", to: "public/auth#create_token_for_discord"
  get "auth/discord", to: "public/auth#sign_in_with_discord"

  # public/users
  get "sign_up", to: "public/users#new"
  post "sign_up/confirm", to: "public/users#confirm"
  post "sign_up", to: "public/users#create"

  # public/events
  get "dashboard", to: "public/events#index"
  get "events/:id", to: "public/events#show"

  # public/programs
  get "events/:event_id/programs/:id", to: "public/programs#show"

  # public/attendances
  get "events/attendance", to: "public/attendances#create"

  #


  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
end
