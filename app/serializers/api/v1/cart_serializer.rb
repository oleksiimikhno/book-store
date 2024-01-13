# frozen_string_literal: true

class Api::V1::CartSerializer < ActiveModel::Serializer
  attributes :id, :status, :created_at
end
