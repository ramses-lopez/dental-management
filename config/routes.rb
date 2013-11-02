DentoSpa::Application.routes.draw do

	get "sign_in" => "sessions#new"
	get "sign_up" => "users#new"
	get "sign_out" => "sessions#destroy"
	resources :users
	resources :sessions

  	get "items/deliver" => "items#deliver"
  	post "items/update_stock" => "items#update_stock"

  	match 'traces/filter' => 'traces#filter', via: [:get, :post]

  	resources :traces, only: [:index]
	resources :invoices
	resources :providers
	resources :items
	resources :invoice_items
	resources :traces

	get "home/index"
	root 'sessions#new'

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

	# Example resource route within a namespace:
	#   namespace :admin do
	#     # Directs /admin/products/* to Admin::ProductsController
	#     # (app/controllers/admin/products_controller.rb)
	#     resources :products
	#   end
end

