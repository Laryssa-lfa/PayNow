Rails.application.routes.draw do
  root 'home#index'

  devise_for :clients
  devise_for :admins

  namespace :employee do
    resources :admins
    resources :companies, only: %i[index show edit update] do
      put 'new_token', on: :member
    end
    resources :change_history_to_companies, only: %i[index create show]
  end
  
  namespace :admin_client do
    resources :companies, only: %i[new create show] do
      put 'new_token', on: :member
      get 'payment_method', on: :collection
    end
    resources :products
    resources :clients
  end

  resources :boletos, only: %i[index new create edit update search_boleto]
  resources :cards, only: %i[index new create edit update search_card]
  resources :pixes, only: %i[index new create edit update search_pix]
  resources :payment_confirmations, only: %i[index new create]

  get 'search_payment', to:"admins#search_payment"
  get 'search_boleto', to:"boletos#search_boleto"
  get 'search_card', to:"cards#search_card"
  get 'search_pix', to:"pixes#search_pix"

  namespace :api do
    namespace :v1 do
      resources :end_clients, only: %i[create]
      resources :billing_issues, only: %i[index show create], param: :token
    end
  end
end
