# frozen_string_literal: true

require 'ffaker'

FactoryBot.define do
  factory :product do
    name { FFaker::Book.title[0, 30] }
    description { FFaker::Book.description }
    price { 5000 }
    quantity { 1 }
  end
end
