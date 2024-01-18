# frozen_string_literal: true

require 'ffaker'
require 'jwt'

SECRET_KEY = Rails.application.secret_key_base

def generate_jwt_token(user)
  JWT.encode({ user_id: user.id }, SECRET_KEY, 'HS256')
end

FactoryBot.define do
  factory :user do
    first_name { FFaker::NameDE.first_name }
    last_name { FFaker::NameDE.last_name }
    email { FFaker::Internet.email }
    password { "Hh4#{Random.hex(7)}" }
  end
end
