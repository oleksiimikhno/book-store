# frozen_string_literal: true

class Product < ApplicationRecord
  # TODO move validation to concerns
  # include Productable

  enum :status, %i[active inactive archived], default: :active

  validates :name, presence: true
  validates :description, presence: true
  validates :meta_title, length: { in: 20..120 }, allow_blank: true
  validates :meta_description, length: { in: 60..200 }, allow_blank: true

  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
