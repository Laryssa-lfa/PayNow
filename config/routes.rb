Rails.application.routes.draw do
  root 'home#index'

  devise_for :clients
  devise_for :admins

  namespace :employee do
    resources :admins
    resources :companies, only: %i[index show edit update] do
      put 'new_token', on: :member
    end
  end
  
  namespace :admin_client do
    resources :companies, only: %i[new create show] do
      put 'new_token', on: :member
    end
    resources :clients
  end

  resources :boletos, only: %i[index new create edit update search_boleto]
  resources :cards, only: %i[index new create edit update search_card]
  resources :pixes, only: %i[index new create edit update search_pix]

  get 'search_payment', to:"admins#search_payment"
  get 'search_boleto', to:"boletos#search_boleto"
  get 'search_card', to:"cards#search_card"
  get 'search_pix', to:"pixes#search_pix"
end
