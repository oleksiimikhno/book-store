# frozen_string_literal: true

require 'ffaker'

FactoryBot.define do
  factory :cart do
    status { 'unpaid' }
    association :user, factory: :user
  end
end
