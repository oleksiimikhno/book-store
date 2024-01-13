# frozen_string_literal: true

class Api::V1::UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email, :created_at
end
