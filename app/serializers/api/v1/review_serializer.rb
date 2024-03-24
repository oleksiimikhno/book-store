# frozen_string_literal: true

class Api::V1::ReviewSerializer < ActiveModel::Serializer
  attributes :id, :text, :rating, :user_id, :created_at
end
