# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  namespace :admin do
    resources :users, :carts, :cart_items, :categories, only: %i[index show new create edit update destroy]

    resources :products, only: %i[index show new create edit update destroy] do
      delete :image, on: :member, action: :destroy_image
      delete :images, on: :member, action: :destroy_images
    end

    root to: 'users#index'
  end

  namespace :api do
    namespace :v1 do
      post '/login', to: 'sessions#create'
      post '/password_update', to: 'passwords#update'

      resource :users do
        get '/all', to: 'users#index'
      end

      resources :products

      resources :carts do
        resources :cart_items, except: :index
      end

      resources :categories do
        resources :products, only: %i[index create]
      end

      resources :search, only: :index
    end
  end
end
