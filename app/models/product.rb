# frozen_string_literal: true

class Product < ApplicationRecord
  include Productable

  has_many :carts
  has_many :carts, through: :cart_items

  enum :status, %i[active inactive archived], default: :active
end
