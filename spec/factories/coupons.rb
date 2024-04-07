# frozen_string_literal: true

require 'ffaker'

FactoryBot.define do
  factory :coupon do
    first_name { FFaker::NameDE.first_name }
    email { FFaker::Internet.email }
    association :user, factory: :user
  end
end
