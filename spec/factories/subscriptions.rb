# frozen_string_literal: true

require 'ffaker'

FactoryBot.define do
  factory :subscription do
    first_name { FFaker::NameDE.first_name }
    email { FFaker::Internet.email }
    status { :inactive }
    association :user, factory: :user
  end
end
