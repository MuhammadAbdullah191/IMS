Rails.application.routes.draw do
  devise_for :admins
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :admins
  resources :suppliers

  resources :brands
  root to: 'admins#dashboard'
end
