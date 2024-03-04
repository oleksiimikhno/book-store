# frozen_string_literal: true

class Api::V1::FieldSerializer < ActiveModel::Serializer
  attributes :value, :label_id, :product_id
end
