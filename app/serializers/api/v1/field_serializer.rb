# frozen_string_literal: true

class Api::V1::FieldSerializer < ActiveModel::Serializer
  attributes :lable_name, :value, :product_id

  def lable_name
    Label.find(object.label_id).title
  end
end
