# frozen_string_literal: true

class Api::V1::ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :meta_title, :meta_description, :quantity, :price, :special_price, :model,
             :status, :category_id, :category_name, :image, :images, :created_at

  has_many :labels, serializer: Api::V1::LabelSerializer
  has_many :fields, serializer: Api::V1::FieldSerializer

  def category_name
    object.category.name
  end

  def image
    return unless object.image.attached?

    url_for(object.image)
  end

  def images
    return unless object.images.attached?

    object.images.map { |image| url_for(image) }
  end
end
