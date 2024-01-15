# frozen_string_literal: true

class Product < ApplicationRecord
  include Productable

  belongs_to :category
  has_many :cart_items
  has_many :carts, through: :cart_items

  enum :status, %i[active inactive archived], default: :active
end
