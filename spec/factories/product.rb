# frozen_string_literal: true

require 'ffaker'

FactoryBot.define do
  factory :product do
    name { FFaker::Book.title[0, 50] }
    description { FFaker::Book.description }
    price { 5000 }
    quantity { 1 }
    association :category, factory: :category

    trait :with_image do
      after :create do |product|
        product.image.attach(
          io: File.open('spec/fixtures/images/image.jpeg'), filename: 'image.jpg', content_type: 'image/jpeg'
        )
      end
    end
  end
end
