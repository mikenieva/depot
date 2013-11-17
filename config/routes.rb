Depot::Application.routes.draw do
  resources :line_items

  resources :carts

  get "store/index"
  resources :products
  
  # The latter tells Rails to create a store_path accessor method
  root 'store#index', as: 'store'

end
