# frozen_string_literal: true

class Api::V1::SubscriptionSerializer < ActiveModel::Serializer
  attributes :email, :user_id
end
