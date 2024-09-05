Rails.application.routes.draw do
  # public/common
  root "public/common#top" # done
  get "401", to: "public/common#unauthorized" # done

  # public/auth
  post "auth/discord", to: "public/auth#create_token_for_discord" # done
  get "auth/discord", to: "public/auth#sign_in_with_discord" # done

  # public/users
  get "sign_up", to: "public/users#new" # done
  post "sign_up/confirm", to: "public/users#confirm" # done
  post "sign_up", to: "public/users#create" # done
  get "sign_up/confirm", to: "public/users#redirect_to_sign_up" # done
  delete "sign_out", to: "public/users#sign_out" # done

  # public/attendances
  get "events/attendance", to: "public/attendances#create"

  # public/events
  get "dashboard", to: "public/events#index"
  # get "events/:id", to: "public/events#show"

  # public/programs
  # get "events/:event_id/programs/:id", to: "public/programs#show"

  # admin/auth
  get "admin", to: "admin/common#top" # done
  get "admin/sign_in", to: "admin/auth#new" # done
  post "admin/sign_in", to: "admin/auth#create" # done
  delete "admin/sign_out", to: "admin/auth#destroy" # done

  # admin/events
  get "admin/events", to: "admin/events#index" # done
  post "admin/events", to: "admin/events#create" # done
  get "admin/events/:public_id", to: "admin/events#show", as: :admin_event # done
  patch "admin/events/:public_id", to: "admin/events#update" # done

  # admin/programs
  get "admin/events/:event_public_id/programs/:public_id", to: "admin/programs#show", as: :admin_program
  post "admin/events/:event_public_id/programs", to: "admin/programs#create", as: :admin_programs
  delete "admin/events/:event_public_id/programs/:public_id", to: "admin/programs#destroy"
  patch "admin/events/:event_public_id/programs/:public_id", to: "admin/programs#update"

  # admin/attendees
  delete "admin/events/:event_public_id/attendees/:id", to: "admin/attendees#destroy_event_attendance", as: :admin_attendee
  delete "admin/events/:event_public_id/programs/:program_public_id/attendees/:id", to: "admin/attendees#destroy_program_attendance", as: :admin_program_attendee

  # admin/users
  get "admin/users", to: "admin/users#index", as: :admin_users
  post "admin/users/:id/sign_in", to: "admin/users#logged_in_as_user", as: :admin_logged_in_as_user
  delete "admin/users/:id", to: "admin/users#destroy", as: :admin_user

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  # root "posts#index"
  match '*path', to: "public/common#not_found", via: :all
end
