# frozen_string_literal: true

require 'ffaker'

FactoryBot.define do
  factory :category do
    name { FFaker::Book.genre[0, 30] }
    description { FFaker::Book.description }
  end
end
