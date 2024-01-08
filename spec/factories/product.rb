# frozen_string_literal: true

require 'ffaker'

FactoryBot.define do
  factory :product do
    name { FFaker::Book.title }
    description { FFaker::Book.description }
  end
end
