Rails.application.routes.draw do

  get 'pendingcommands/index'

  get 'pendingcommands/create'

  resources :device_dashboard, only:  [:index, :show]
  resources :devices do
    resources :pendingcommands, only: [:index, :create], :defaults => {:format => :json}
    resources :uploaded_files, only: [:index, :show, :destroy]
  end

  if Settings.registration.invite_only
    devise_for :users, :controllers => { :registrations => "registration_disabled" }
  else
    devise_for :users
  end

  ActiveAdmin.routes(self)

  get 'main_page/index'
  root 'main_page#index'

  #get 'locationhistory' => 'location_history#index'

  resources :location_history, only:  [:index, :show]

  namespace :api, :defaults => {:format => :json}, :constraints => {:format => /(xml|json)/} do
    namespace :v1 do
      resource :device, path: ":device_key", only: [:update, :show] do
        resources :locations, only: [:create]
        resources :pendingcommands, only: [:index, :update]
        resources :messages, only: [:create]
        resources :uploaded_files, only: [:create]
      end
    end
  end

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
