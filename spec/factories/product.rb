# frozen_string_literal: true

require 'ffaker'

FactoryBot.define do
  factory :product do
    name { FFaker::Book.title[0, 50] }
    description { FFaker::Book.description }
    price { 5000 }
    quantity { 1 }
    association :category, factory: :category
  end
end
