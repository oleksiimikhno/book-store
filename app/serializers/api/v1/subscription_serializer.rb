# frozen_string_literal: true

class Api::V1::SubscriptionSerializer < ActiveModel::Serializer
  attributes :email, :status, :token
end
