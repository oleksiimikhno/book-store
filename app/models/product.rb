# frozen_string_literal: true

class Product < ApplicationRecord
  include Productable

  acts_as_paranoid

  belongs_to :category
  has_many :cart_items
  has_many :carts, through: :cart_items

  enum :status, %i[active inactive archived], default: :active

  default_scope { order(created_at: :desc) }
  scope :order_by, ->(type = :desc) { reorder(created_at: type) if type.present? }
end
