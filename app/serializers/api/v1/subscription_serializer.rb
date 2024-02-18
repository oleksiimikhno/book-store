# frozen_string_literal: true

class Api::V1::SubscriptionSerializer < ActiveModel::Serializer
  attributes :email, :status, :unsubscription_token
end
