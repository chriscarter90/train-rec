Progress360::Application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  root :to => redirect('/dashboard')
  get '/dashboard' => 'dashboard#index', :as => :dashboard
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get 'components', to: 'components#index', as: 'components'

  resources :achievements, only: [:index, :new, :create, :destroy, :update]
  resources :trackers, only: [:show, :new, :create, :destroy] do
    resources :achievements, only: [:new, :create]
  end
  resources :sessions, only: [:new, :create, :destroy]
  resource :learner, only: [:show, :edit, :update], as: :profile do
    resources :reports, except: [:destroy]
    resources :focus_positions, only: [:index]
    resources :focus_positions_updates, only: [:index]
  end

  get 'admin' => 'admin#show', :as => :admin
  namespace :admin do
    resources :learners, except: [:destroy]
    resources :trackers, only: [:index]
    resources :achievements, only: [:index]
  end

  # You can have the root of your site routed with "root"

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

  # Jasmine test runner
  mount JasmineRails::Engine => "/specs" if defined?(JasmineRails)
end
