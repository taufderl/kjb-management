Rails.application.routes.draw do
  resources :news
  resources :bookings
  resources :scouts_accounts
  resources :children_accounts
  resources :main_accounts
  resources :main_accounts
  post 'disbursements/clear/:id' => "disbursements#clear", as: :clear_disbursement
  resources :disbursements
  resources :settings
  resources :goods
  
  get 'scouts_bookkeeping/index'
  get 'scouts_bookkeeping/index2'
  get 'scouts_bookkeeping/billing'
  get 'scouts_bookkeeping/input'
  get 'scouts_bookkeeping/payment'  
  get 'scouts_bookkeeping/count_cash'
  post 'scouts_bookkeeping/save_cash'
  
  post 'scouts_bookkeeping/new_payment' => 'scouts_bookkeeping#new_payment', as: :new_scouts_payment
  post 'bookings/create_payment' => 'bookings#create_payment'
  
  post 'scouts_bookkeeping/new_entry/:scout_id' => 'scouts_bookkeeping#new_entry', as: :new_scout_consumption
  patch 'scouts_bookkeeping/update_entry/:scout_consumption_id' => 'scouts_bookkeeping#update_entry', as: :update_scout_consumption

  # get 'scouts_bookkeeping/payment/autocomplete_scout_first_name'

  get 'main_bookkeeping/index'
  get 'main_bookkeeping/billing', as: :main_bookkeeping_billing
  
  get 'main_bookkeeping/count_cash'
  post 'main_bookkeeping/save_cash'
  
  get 'shop' => 'shop#index', as: :shop
  post 'shop/select_time_of_day', as: :select_time_of_day
  get 'shop/autocomplete_child_first_name'
  post 'shop/new_entry' => 'shop#new_entry', as: :new_child_consumption
  patch 'shop/update_entry/:child_consumption_id' => 'shop#update_entry', as: :update_child_consumption

  get 'import/index', as: :import

  resources :users
  resources :accounts
  resources :scouts
  resources :tents
  
  root 'dashboard#index', as: 'dashboard'
  post 'dashboard/select_user', as: :select_user
  post 'dashboard/select_date', as: :select_date

  resources :children
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
