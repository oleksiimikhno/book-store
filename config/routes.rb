# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  namespace :admin do
    resources :users, :carts, :products, only: %i[index show new create edit update destroy]

    root to: 'users#index'
  end

  namespace :api do
    namespace :v1 do
      post '/login', to: 'sessions#create'
      post '/password_update', to: 'passwords#update'

      resources :users, :products, :carts

      resources :categories do
        resources :products, only: %i[index create]
      end

      resources :cart_items, only: %i[show create update destroy]
    end
  end
end
