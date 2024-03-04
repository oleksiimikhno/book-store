FactoryBot.define do
  factory :favorite do
    association :user, factory: :user
    association :product, factory: :product
  end
end
