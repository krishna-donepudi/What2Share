Rails.application.routes.draw do
  resources :user_apps
  resources :apps
  resources :users
  resources :sessions

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'home', to: 'home#index', as: :home
  get 'signup' => 'users#new', :as => :signup
  get 'login' => 'sessions#new', :as => :login
  get 'logout' => 'sessions#destroy', :as => :logout

  get 'users/:id/edit_apps', to: 'users#edit_apps'
  patch 'users/:id/edit_apps', to: 'users#update_apps'
  
  root 'home#index' 
end
