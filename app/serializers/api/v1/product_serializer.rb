# frozen_string_literal: true

include Rails.application.routes.url_helpers

class Api::V1::ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :meta_title, :meta_description, :quantity, :price, :status, :category_id,
             :image, :images, :created_at

  def image
    return unless object.image.attached?

    image_url([object.image])
  end

  def images
    return unless object.images.attached?

    image_url(object.images)
  end

  def image_url(images)
    images.map { |image| rails_blob_path(image, only_path: true) }
  end
end
