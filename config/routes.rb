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

  authenticate :diver, ->(diver) { diver.admin? } do
    mount SolidErrors::Engine, at: "/errors"
  end

  resources :animals, except: [:show]

  resources :benthic_covers do
    post :draft, on: :collection
  end

  resources :boat_logs, except: [:show] do
    post :draft, on: :collection
  end

  resources :boatlog_managers, except: [:show]

  resources :coral_demographics do
    post :draft, on: :collection
  end

  resources :corals, except: [:show]

  resources :cover_cats, except: [:show]

  get "dashboard/show"

  resources :divers, except: [:show]

  resources :habitat_types, except: [:show]

  resources :sample_types, except: [:show]

  resources :samples do
    post :draft, on: :collection
  end

  get "samples/:id/proofing_template" => "samples#proofing_template"

  get "static_pages/home"
  get "static_pages/help"

  root to: "static_pages#home"
end
