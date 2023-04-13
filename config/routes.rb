Rails.application.routes.draw do
  devise_for :admins, skip: [:password]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :admins
  resources :suppliers
  resources :brands
  resources :categories
  resources :products do
    member do
      delete :delete_image_attachment
      post :add_to_cart
      delete :remove_from_cart
    end

  end

  resources :orders do
    member do
      get :download
    end

  end

  resources :order_items, only: [:index, :show]
  root to: 'orders#index'

  match '*unmatched', to: 'application#route_not_found', via: :all, constraints: lambda { |req|
    req.path.exclude? 'rails/active_storage'
  }
end
