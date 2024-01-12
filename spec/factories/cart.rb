# frozen_string_literal: true

require 'ffaker'

FactoryBot.define do
  factory :user do
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    email { FFaker::Internet.free_email }
    password { 'Password123' }
  end

  factory :cart do
    status { ',
              user_id: { type: :integer }' }
    association :user
  end
end
