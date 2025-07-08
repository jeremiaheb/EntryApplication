EntryApplication::Application.routes.draw do
  get "dashboard/show"

  resources :boat_logs do
    post :draft, on: :collection
  end

  resources :corals
  
  resources :cover_cats

  resources :coral_demographics do
    post :draft, on: :collection
  end

  resources :benthic_covers do
    post :draft, on: :collection
  end

  resources :boatlog_managers

  #devise_for :divers
  devise_for :divers, :skip => [:registrations]
  devise_scope :diver do
    get "signin",                       :to => "devise/sessions#new"
    get "signout",                      :to => "devise/sessions#destroy"
    get "cancel_diver_registration",    :to => "devise/registrations#cancel"
    put "diver_registration",           :to => "devise/registrations#update"
    get "edit_diver_registration",      :to => "devise/registrations#edit"
  end

  get "static_pages/home"

  get "static_pages/help"


  resources :divers

  resources :habitat_types

  resources :sample_types

  resources :samples do
    post :draft, on: :collection
  end

  resources :animals

  get 'samples/:id/proofing_template' => 'samples#proofing_template'
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'static_pages#home'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
