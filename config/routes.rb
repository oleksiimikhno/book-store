# frozen_string_literal: true

require 'sidekiq/web'

Sidekiq::Web.app_url = '/'

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  mount Sidekiq::Web => '/sidekiq'

  namespace :admin do
    resources :users, :carts, :cart_items, :categories, :labels, :fields, only: %i[index show new create edit update destroy]

    resources :products, only: %i[index show new create edit update destroy] do
      member do
        delete :image, action: :destroy_image
        delete :images, action: :destroy_images
      end
    end

    root to: 'users#index'
  end

  namespace :api do
    namespace :v1 do
      post '/login', to: 'sessions#create'
      post '/password_reset', to: 'passwords#create'
      post '/password_update', to: 'passwords#update'

      resource :users do
        get '/all', to: 'users#index'
      end

      resources :products do
        member do
          post 'add_label/:label_id', to: 'products#add_label', as: 'add_label'
          delete 'remove_label/:label_id', to: 'products#remove_label', as: 'remove_label'
        end
      end
      resources :products_awaitings, only: :index
      resources :products_bestsellers, only: :index

      resources :carts do
        resources :cart_items, except: :index
      end

      resources :categories do
        resources :products, only: %i[index create]
      end

      resources :search, only: :index

      resources :subscriptions, only: %i[create]
      delete '/unsubscription', to: 'subscriptions#destroy'
      get '/subscription', to: 'subscriptions#show'

      resources :favorites, only: %i[index create]
      delete '/favorites', to: 'favorites#destroy'

      resources :labels do
        resources :fields
      end
    end
  end
end
