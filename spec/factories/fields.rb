# frozen_string_literal: true

FactoryBot.define do
  factory :field do
    value { 'Test' }

    association :label, factory: :label
    association :product, factory: :product
  end
end
