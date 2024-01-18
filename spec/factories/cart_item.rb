FactoryBot.define do
  factory :cart_item do
    quantity { 100 }
    price { 1000.0 }
    association :cart, factory: :cart
    association :product, factory: :product
  end
end
