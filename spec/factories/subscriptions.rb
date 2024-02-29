FactoryBot.define do
  factory :subscription do
    email { 'testmail@gmail.com' }
    status { :inactive }
    association :user, factory: :user
  end
end
