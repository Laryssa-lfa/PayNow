Rails.application.routes.draw do
  root 'home#index'

  devise_for :clients
  devise_for :admins

  resources :admins
end
