# frozen_string_literal: true

require 'ffaker'

FactoryBot.define do
  factory :user do
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    email { FFaker::Internet.email }
    password { "Hh4#{Random.hex(7)}" }
  end
end
