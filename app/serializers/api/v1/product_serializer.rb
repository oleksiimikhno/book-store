# frozen_string_literal: true

class Api::V1::ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :meta_title, :meta_description, :quantity, :price, :special_price, :model,
             :status, :category_id, :category_name, :image, :images, :created_at

  has_many :labels, serializer: Api::V1::LabelSerializer do
    object.labels.order(id: :asc)
  end
  has_many :fields, serializer: Api::V1::FieldSerializer do
    object.fields.order(label_id: :asc)
  end

  def category_name
    object.category.name
  end

  def image
    return unless object.image.attached?

    image_url([object.image])
  end

  def images
    return unless object.images.attached?

    image_url([object.image])
  end

  def image_url(images)
    images.map { |image| image.blob.url }
  end
end
