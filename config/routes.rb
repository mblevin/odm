Odm::Application.routes.draw do

  root :to => 'home#index'
  resources :users do
    resources :maps do
      resources :events
    end
  end

  match '/find_place' => 'events#find_place', :via => :post
  match '/get_place' => 'events#get_place', :via => :post
  match '/save_event' => 'events#save_event', :via => :post
  match '/get_event' => 'events#get_event', :via => :get

  match '/dashboard' => 'users#dashboard', :via => :get

  match '/login' => 'session#new', :via => :get
  match '/login' => 'session#create', :via => :post
  match '/logout' => 'session#destroy', :via => :get

  match '/change-password' => 'users#change_password', :via => :get, :as => 'change_password'
  match '/change-password' => 'users#change_password', :via => :post, :as => 'change_password'

  match '/partners' => 'home#partners', :via => :get
  match '/partner-dashboard' => 'users#partner_dashboard', :via => :get

  match '/similar' => 'users#similar', :via => :get
  match '/similar' => 'users#find_similar', :via => :post

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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
