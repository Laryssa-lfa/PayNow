Rails.application.routes.draw do
  root 'home#index'

  devise_for :clients
  devise_for :admins

  namespace :employee do
    resources :admins
  end
end
