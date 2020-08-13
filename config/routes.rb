Rails.application.routes.draw do
  get 'users/:id/edit_apps', to: 'users#edit_apps', as: :edit_apps

  get 'users/:id/edit_user_apps_1', to: 'users#edit_user_apps_1', as: :edit_user_apps_1

  get 'users/:id/edit_user_apps_2', to: 'users#edit_user_apps_2', as: :edit_user_apps_2

  resources :user_apps
  resources :apps
  resources :users
  resources :sessions

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'home', to: 'home#index', as: :home
  get 'signup' => 'users#new', :as => :signup
  get 'login' => 'sessions#new', :as => :login
  get 'logout' => 'sessions#destroy', :as => :logout
  
  root 'home#index' 
end
