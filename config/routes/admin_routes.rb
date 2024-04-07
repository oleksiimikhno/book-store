module AdminRoutes
  def self.extended(router)
    router.instance_exec do
      namespace :admin do
        resources :users,
                  :carts,
                  :cart_items,
                  :categories,
                  :labels,
                  :fields,
                  :reviews,
                  :coupons,
                  only: %i[index show new create edit update destroy]

        resources :products, only: %i[index show new create edit update destroy] do
          member do
            delete :image, action: :destroy_image
            delete :images, action: :destroy_images
          end
        end

        root to: 'users#index'
      end
    end
  end
end
