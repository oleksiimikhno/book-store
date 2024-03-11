# frozen_string_literal: true

class Api::V1::ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :meta_title, :meta_description, :quantity, :price, :special_price, :model,
             :status, :category_id, :image, :images, :created_at

  has_many :labels, serializer: Api::V1::LabelSerializer
  has_many :fields, serializer: Api::V1::FieldSerializer

  def image
    return unless object.image.attached?

    image_url([object.image])
  end

  def images
    return unless object.images.attached?

    image_url(object.images)
  end

  def image_url(images)
    images.map { |image| Rails.application.routes.url_helpers.rails_blob_url(image, only_path: true) }
  end
end
