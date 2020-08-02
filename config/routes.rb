Rails.application.routes.draw do
  resources :user_apps
  resources :apps
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'home', to: 'home#index', as: :home

  
  root 'home#index' 
end
