# frozen_string_literal: true

class Api::V1::CategorySerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :meta_title, :meta_description, :created_at

  has_many :products, each_serializer: Api::V1::ProductSerializer
end
