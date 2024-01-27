# frozen_string_literal: true

class Product < ApplicationRecord
  include Productable

  belongs_to :category
  has_many :cart_items
  has_many :carts, through: :cart_items

  has_one_attached :image, dependent: :destroy
  has_many_attached :images, dependent: :destroy


  enum :status, %i[active inactive archived], default: :active

  default_scope { order(created_at: :desc) }
  scope :order_by_date, ->(type = :desc) { reorder(created_at: type) if type.present? }
  scope :order_by_price, ->(type = :desc) { reorder(price: type) if type.present? }
end
