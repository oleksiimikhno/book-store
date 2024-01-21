# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  namespace :admin do
    resources :users, :carts, :products, :cart_items, only: %i[index show new create edit update destroy]

    root to: 'users#index'
  end

  namespace :api do
    namespace :v1 do
      post '/login', to: 'sessions#create'
      post '/password_update', to: 'passwords#update'

      resource :users
      resources :products

      resources :carts do
        resources :cart_items, except: :index
      end

      resources :categories do
        resources :products, only: %i[index create]
      end
    end
  end
end
