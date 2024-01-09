# frozen_string_literal: true

require 'ffaker'

# TODO update user_id

FactoryBot.define do
  factory :cart do
    user_id { 1 }
  end
end
