# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  namespace :admin do
    resources :users
    resources :carts
    resources :products

    root to: 'users#index'
  end

  namespace :api do
    namespace :v1 do
      resources :products
      resources :users
      resources :carts
    end
  end
end
