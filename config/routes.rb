EntryApplication::Application.routes.draw do
  devise_for :divers, skip: [:registrations], controllers: {
    omniauth_callbacks: "divers/omniauth_callbacks",
  }
  devise_scope :diver do
    get "signin",                       to: "devise/sessions#new"
    get "signout",                      to: "devise/sessions#destroy"
    get "cancel_diver_registration",    to: "devise/registrations#cancel"
    put "diver_registration",           to: "devise/registrations#update"
    get "edit_diver_registration",      to: "devise/registrations#edit"
  end

  # For testing unhandled exceptions via solid_errors
  get "/crash", to: ->(env) { raise "/crash intentionally generated this error for testing error reporting" }

  # Admin only routes
  authenticate :diver, ->(diver) { diver.admin? } do
    mount SolidErrors::Engine, at: "/errors"

    resources :cleanups, only: [:new, :create]
  end

  resources :agencies, except: [:show]

  resources :animals, except: [:show]

  resources :benthic_covers do
    post :draft, on: :collection
  end

  resources :boat_logs do
    post :draft, on: :collection
  end

  resources :coral_demographics do
    post :draft, on: :collection
  end

  resources :corals, except: [:show]

  resources :cover_cats, except: [:show]

  get "dashboard/show"

  resources :divers, except: [:show]

  resources :habitat_types, except: [:show]

  resources :missions, except: [:show]

  resources :projects, except: [:show]

  resources :regions, except: [:show]

  resources :sample_types, except: [:show]

  resources :samples do
    post :draft, on: :collection
  end

  root to: "home#index"
end
