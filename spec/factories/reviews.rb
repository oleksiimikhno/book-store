FactoryBot.define do
  factory :review do
    text { 'Review text' }
    rating { 1 }
    association :user, factory: :user
    association :reviewable, factory: :product
  end
end
