# frozen_string_literal: true

class Api::V1::LabelSerializer < ActiveModel::Serializer
  attributes :id, :title
end
