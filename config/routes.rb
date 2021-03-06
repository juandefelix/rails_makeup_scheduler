
RailsMakeupScheduler::Application.routes.draw do
  devise_for :users, :path => '', :path_names => {:sign_in => 'sign_in', :sign_out => 'logout'}, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
  root 'static_pages#home'
  match '/help',   to: 'static_pages#help',   via: 'get'
  match '/contact',  to: 'static_pages#contact',  via: 'get'
  match '/admin_help',  to: 'static_pages#admin_help',  via: 'get'
  
  match '/cancellations(/:year(/:month))', to: 'cancellations#index', via: 'get', :as => :cancellations, 
                                          :constraints => {:year => /\d{4}/, :month => /\d{1,2}/}

  match '/admin/cancellations(/:year(/:month))', to: 'admin/cancellations#index', via: 'get', :as => :admin_cancellations, 
                                          :constraints => {:year => /\d{4}/, :month => /\d{1,2}/}
                  
  match '/admin/cancellations/:year/:month/:day', to: 'admin/cancellations#day', via: 'get', :as => :day_admin_cancellations,
                                          :constraints => {:year => /\d{4}/, :month => /\d{1,2}/, :day => /\d{1,2}/}
  
  resources :users, :cancellations

  namespace :admin do
   resources :cancellations, :users
  end

  get '*fallback', to: 'static_pages#fallback'

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
