# frozen_string_literal: true

class Api::V1::LabelSerializer < ActiveModel::Serializer
  attributes :id, :title

  has_many :fields, serializer: Api::V1::FieldSerializer
end
