Rails.application.routes.draw do
  devise_for :admins
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :admins
  resources :suppliers
  resources :brands
  resources :categories
  resources :products do
    member do
      delete :delete_image_attachment
    end
  end
  resources :orders do
    member do
      get :preview
      get :download
    end
  end
  resources :order_items

  post "products/add_to_cart/:id", to: "products#add_to_cart", as: "add_to_cart"
  delete "products/remove_from_cart/:id", to: "products#remove_from_cart", as: "remove_from_cart"
  root to: 'orders#index'

  match '*unmatched', to: 'application#route_not_found', via: :all, constraints: lambda { |req|
    req.path.exclude? 'rails/active_storage'
  }
end
