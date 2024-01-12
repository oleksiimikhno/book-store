# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  namespace :api do
    namespace :v1 do
      post '/login', to: 'authentications#login'
      post '/update_password', to: 'authentications#update_password'

      resources :users
      resources :products
      resources :carts
    end
  end
end
